public class move : MonoBehaviour
{
    public float speed = 5f; // Скорость движения игрока
    public int health;
    public Animator animator;
    public string damageAnim;
    public string death;
    public string moveAnim;
    public string stayAnim;
    public Sprite leftSprite; // Спрайт для движения влево
    public Sprite rightSprite; // Спрайт для движения вправо
    public Text healthText; // Объект Text для отображения здоровья
    public GameObject weapon;

    private SpriteRenderer spriteRenderer; // Компонент для отображения спрайтов
    private bool isDeath = false;
    private void Start()
    {
        spriteRenderer = GetComponent<SpriteRenderer>();
        animator = GetComponent<Animator>();
    }

    private void Update()
    {
        if (isDeath)
        {
            return;
        }

        float horizontalMovement = Input.GetAxisRaw("Horizontal"); // Получаем ввод по горизонтали (A, D, ←, →)
        float verticalMovement = Input.GetAxisRaw("Vertical"); // Получаем ввод по вертикали (W, S, ↑, ↓)

        Vector2 movementDirection = new Vector2(horizontalMovement, verticalMovement).normalized; // Создаем нормализованный вектор направления движения

        if (movementDirection != Vector2.zero)
        {
            // Если игрок движется, то проигрываем анимацию ходьбы
            animator.Play(moveAnim);
            transform.position = (Vector2)transform.position + movementDirection * speed * Time.deltaTime; // Двигаем игрока в направлении, указанном игроком со скоростью speed
        }
        else
        {
            // Если игрок стоит на месте, то проигрываем анимацию стояния
            animator.Play(stayAnim);
        }

        if (movementDirection.x > 0f)
        {
            spriteRenderer.flipX = false; // Отображаем спрайт для движения вправо и не зеркалим его
        }
        else if (movementDirection.x < 0f)
        {
            spriteRenderer.flipX = true; // Отображаем спрайт для движения влево и зеркалим его
        }

        // Обновляем значение здоровья на UI
        healthText.text = "Health: " + health.ToString();
    }

    public void TakeDamage(int damage)
    {
        if (isDeath)
        {
            return;
        }
        else
        {
            health -= damage;
            animator.Play(damageAnim);
            if (health <= 0)
            {
                isDeath = true;
                animator.Play(death);
                speed = 0f;
                health = 0;
                healthText.text = "Health: " + health.ToString();
                weapon.SetActive(false);
            }
        }
    }
}
