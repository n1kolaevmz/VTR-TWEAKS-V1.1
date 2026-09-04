# VTR Tweaks - High Performance Windows Optimization

VTR Tweaks is a Windows optimization script designed to maximize FPS, minimize input latency, and eliminate micro-stutters for gaming and high-performance workloads.

VTR Tweaks е оптимизационен скрипт за Windows, създаден с цел максимален FPS, минимално закъснение (input lag) и премахване на насичанията при гейминг и тежки натоварвания.

---

## Key Features / Основни функции

* **Low Latency & Timers:** BCDEDIT, HPET, and system timer adjustments for reduced peripheral input delay.
* **GPU & DWM Optimization:** Enables HAGS, Direct Flip, and DirectX 11/12 asynchronous compute optimizations.
* **Memory Management:** Disables background RAM compression and stops unneeded background services.
* **Debloat & Privacy:** Removes pre-installed Windows bloatware, telemetry, background tracking, and Copilot services.
* **Storage Optimization:** Adjusts DPC/MSI interrupts for NVMe and SSD drives to lower I/O latency.
* **System Protection:** Includes an optional System Restore Point creation before applying changes.

---

## How to Run / Инструкции за инсталация

1. Download the latest release package.
2. Extract the **VTR Tweaks** directory.
3. Right-click `VTR_Tweaks.bat` and select **Run as Administrator**.
4. Choose whether to create a System Restore Point when prompted.
5. Reboot your system after completion for all changes to take effect.

1. Изтеглете последната версия.
2. Разархивирайте съдържанието в отделна папка.
3. Натиснете с десен бутон върху `VTR_Tweaks.bat` и изберете **Run as Administrator**.
4. Потвърдете или откажете създаването на System Restore Point.
5. Рестартирайте компютъра след приключване на процеса.

---

## Disclaimer / Отказ от отговорност

This script modifies core Windows Registry settings and system services. Use it at your own discretion. Creating a System Restore Point prior to execution is strongly recommended.

Този скрипт модифицира ключови настройки в системния регистър и услугите на Windows. Използвайте го на собствена отговорност. Препоръчително е да създадете точка за възстановяване преди изпълнение.
