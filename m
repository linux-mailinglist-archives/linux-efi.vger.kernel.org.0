Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DD9E7117926
	for <lists+linux-efi@lfdr.de>; Mon,  9 Dec 2019 23:19:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726522AbfLIWTE (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 9 Dec 2019 17:19:04 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40360 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726230AbfLIWTD (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 9 Dec 2019 17:19:03 -0500
Received: by mail-wr1-f67.google.com with SMTP id c14so17892817wrn.7
        for <linux-efi@vger.kernel.org>; Mon, 09 Dec 2019 14:19:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6Pdv8zCfnZ7IiuSoZWi5C8g7n7BXRx/oumm+Zrs7Uo0=;
        b=V7FYy/zI3CZ2GBSW54HGfs1VzwMc6HJ1bVwtpqQwtmPiKHQKzEardxw574fhcJP/f3
         4cBGUj74DGzPrJrnv66rIE59fvQR2xiCljvGpP5vseKHNmOdZlqb2bbFVk2tnnJRp1UA
         Jt7cbjvZ1PgV4NicveDzi9WLvQAxBS0WG71hKPD382bU8Tcc610IBGh4ZicvD4Y/NW6r
         MFOyKhENjg/g3fhX6tcUeXCavTrF1R50VkSrrxmnEYpcr/7Nc9WG2srtBU4D+RcPqWvX
         mkLxTG2jtNy5vUgn6sxKK2B1kSOkT8qtC/cz9fFLxStTcNdeb1wIplkvwTg7rC/JnK95
         jEDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6Pdv8zCfnZ7IiuSoZWi5C8g7n7BXRx/oumm+Zrs7Uo0=;
        b=SSryXLWkcaMUFHflGQI//BwgQttETHh4oRvYjrX6a3g78WzP21/uJ4Rj1ME50OrrOH
         6+lnRvaKrDF+iuLmX/k/GrCT2cr4kPVhLe+1/zk7CFzEuYBsyNGLDl2lw1q35dQeuyVx
         GwXYNx40sxJRNhKVOjy/RZtIW1zjnSbGBP5lhBM67SiN3EEsweVUNBAX4ymoLkxOx+BI
         29SZVwdoIi4KcPVdbLbw49+J6DcvkiS00VNYMPRNi8Nb4a+ROgpkxUG+afNXy75buVFn
         QPfHezl97mxlbKmry2XnjQJ5s88fUxz1HsJ2+JEXrFMEpoORm0m+9qYhs2jVoYoIfdnT
         DCuA==
X-Gm-Message-State: APjAAAWsxXiZWFt3o27KZGmca9qmrdoVKIkPGidCmPEgDKOhLMjdesdy
        durnDLHBzKcr4rfpGodN5+tnsfwvzNpovFvnip9QjHhBonAcSuEJ
X-Google-Smtp-Source: APXvYqwyvwH9sRJOQcR3RQhqrVQuvavjlaNKELTaeieBsbKEgGUV55Xr5LxeTGl6dNS1rSgjItiyHbnHhU8OQPnH5uo=
X-Received: by 2002:a5d:6652:: with SMTP id f18mr4662355wrw.246.1575929940822;
 Mon, 09 Dec 2019 14:19:00 -0800 (PST)
MIME-Version: 1.0
References: <20191209220559.GA23486@bicusdicus>
In-Reply-To: <20191209220559.GA23486@bicusdicus>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Mon, 9 Dec 2019 22:18:59 +0000
Message-ID: <CAKv+Gu9=W99NFWT87HSi-gUkavmwxZ7ii8PY-4Mp0mR+T=n=QQ@mail.gmail.com>
Subject: Re: PROBLEM: Kernel 5.4.2 Oops: ARCH=i386, Intel n270 CPU,
 CONFIG_EFI_RCI2=y, CONFIG_HIHGMEM64G=y
To:     chalapticus@furaezit.eu
Cc:     linux-efi <linux-efi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, 9 Dec 2019 at 23:06, <chalapticus@furaezit.eu> wrote:
>
> Hi,
>
> I would like to report the following oops in the 5.4.2 kernel:
>
> [1.] One line summary of the problem:
> Kernel 5.4.2 Oops: ARCH=i386, Intel n270 CPU, CONFIG_EFI_RCI2=y, HIHGMEM64G=y
>
> [2.] Full description of the problem/report:
> When running on an Intel n270CPU, there is a kernel oops during booting,
> before trying to run init. The kernel is compiled for ARCH=i386 with
> CONFIG_EFI_RCI2=y and HIHGMEM64G=y.
>
> The problem was first experienced on real HW (Acer Aspire One and ASUS EEEPC
> 1201) and it is reproducable with `qemu-system-i386' if setting the cpu to
> `n270'.
>
> The oops does only happen if EFI_RCI2=y and HIGHMEM64G=y; the following
> combinations do not trigger it (EFI_RCI2=y, HIGHMEM4G=y), (EFI_RCI2=n,
> HIGHMEM64G=y) and (EFI_RCI2=n, HIGHMEM4G=y).
>

Thanks for the report. This issue should be fixed by

https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git/commit/?id=e66aa5396bce113586d0f67e335fac8dd79b5e70



> [3.] Keywords (i.e., modules, networking, kernel):
> kernel, i386, Intel-Atom-n270, EFI_RCI2, HIGHMEM
>
> [4.] Kernel information
> [4.1.] Kernel version (from /proc/version):
> 5.4.2 (*not* from /proc/version, the kernel could not boot)
>
> [4.2.] Kernel .config file:
> Attached. It was created by making a defconfig and then setting
> HIHGMEM64G and EFI_RCI2 in menuconfig
>
> [5.] Most recent kernel version which did not have the bug:
> I cannot provide information.
>
> [6.] Output of Oops.. message (if applicable) with symbolic information
>      resolved (see Documentation/admin-guide/bug-hunting.rst)
> [    0.771304] resource sanity check: requesting [mem 0xffffffff-0x10000001c], which spans more than Reserved [mem 0xfffc0000-0xffffffff]
> [    0.772294] caller memremap+0x69/0x180 mapping multiple BARs
> [    0.772768] BUG: unable to handle page fault for address: f7e1d005
> [    0.773283] #PF: supervisor read access in kernel mode
> [    0.773704] #PF: error_code(0x0009) - reserved bit violation
> [    0.774166] *pdpt = 0000000001ea0001 *pde = 000000003242f067 *pte = 8000000100000173
> [    0.774802] Oops: 0009 [#1] SMP NOPTI
> [    0.775103] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.4.2 #1
> [    0.775578] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.10.2-0-g5f4c7b1-prebuilt.qemu-project.org 04/01/2014
> [    0.776846] EIP: strncmp+0xc/0x20
> [    0.777130] Code: e5 57 89 d7 56 89 c6 ac ae 75 08 84 c0 75 f8 31 c0 eb 04 19 c0 0c 01 5e 5f 5d c3 8d 76 00 55 89 e5 57 89 d7 56 89 c6 49 78 08 <ac> ae 75 08 84 c0 75 f5 31 c0 eb 04 19 c0 0c 01 5e 5f 5d c3 55 89
> [    0.778673] EAX: f7e1d005 EBX: 00000007 ECX: 00000003 EDX: c1c5a396
> [    0.779184] ESI: f7e1d005 EDI: c1c5a396 EBP: f24d9f0c ESP: f24d9f04
> [    0.779695] DS: 007b ES: 007b FS: 00d8 GS: 00e0 SS: 0068 EFLAGS: 00010206
> [    0.780247] CR0: 80050033 CR2: f7e1d005 CR3: 01ea4000 CR4: 000006e0
> [    0.780760] Call Trace:
> [    0.780967]  ? efi_runtime_map_init+0x18c/0x18c
> [    0.781342]  efi_rci2_sysfs_init+0x4d/0x151
> [    0.781687]  ? efi_runtime_map_init+0x18c/0x18c
> [    0.782058]  do_one_initcall+0x3d/0x1cf
> [    0.782377]  ? set_debug_rodata+0xf/0xf
> [    0.782692]  kernel_init_freeable+0x142/0x1d2
> [    0.783050]  ? rest_init+0x90/0x90
> [    0.783332]  kernel_init+0x8/0xf0
> [    0.783609]  ret_from_fork+0x19/0x38
> [    0.783903] Modules linked in:
> [    0.784168] CR2: 00000000f7e1d005
> [    0.784594] ---[ end trace d2ad344abd34f7b5 ]---
> [    0.784983] EIP: strncmp+0xc/0x20
> [    0.785344] Code: e5 57 89 d7 56 89 c6 ac ae 75 08 84 c0 75 f8 31 c0 eb 04 19 c0 0c 01 5e 5f 5d c3 8d 76 00 55 89 e5 57 89 d7 56 89 c6 49 78 08 <ac> ae 75 08 84 c0 75 f5 31 c0 eb 04 19 c0 0c 01 5e 5f 5d c3 55 89
> [    0.786899] EAX: f7e1d005 EBX: 00000007 ECX: 00000003 EDX: c1c5a396
> [    0.787427] ESI: f7e1d005 EDI: c1c5a396 EBP: f24d9f0c ESP: f24d9f04
> [    0.787951] DS: 007b ES: 007b FS: 00d8 GS: 00e0 SS: 0068 EFLAGS: 00010206
> [    0.788523] CR0: 80050033 CR2: f7e1d005 CR3: 01ea4000 CR4: 000006e0
> [    0.789097] Kernel panic - not syncing: Attempted to kill init! exitcode=0x00000009
> [    0.789805] Kernel Offset: 0x0 from 0xc1000000 (relocation range: 0xc0000000-0xf7dfdfff)
> [    0.790481] ---[ end Kernel panic - not syncing: Attempted to kill init! exitcode=0x00000009 ]---
>
> From gdb:
> ---------
>
> (gdb) l *strncmp+0xc
> 0xc1a0d8ac is in strncmp (arch/x86/lib/string_32.c:122).
> 117     #ifdef __HAVE_ARCH_STRNCMP
> 118     int strncmp(const char *cs, const char *ct, size_t count)
> 119     {
> 120             int res;
> 121             int d0, d1, d2;
> 122             asm volatile("1:\tdecl %3\n\t"
> 123                     "js 2f\n\t"
> 124                     "lodsb\n\t"
> 125                     "scasb\n\t"
> 126                     "jne 3f\n\t"
>
> (gdb) l *efi_runtime_map_init+0x18c
> 0xc1e18a1d is in efi_rci2_sysfs_init (drivers/firmware/efi/rci2-table.c:80).
> 75
> 76              return chksum;
> 77      }
> 78
> 79      static int __init efi_rci2_sysfs_init(void)
> 80      {
> 81              struct kobject *tables_kobj;
> 82              int ret = -ENOMEM;
> 83
> 84              rci2_base = memremap(rci2_table_phys,
>
> (gdb) l *efi_rci2_sysfs_init+0x4d
> 0xc1e18a6a is in efi_rci2_sysfs_init (drivers/firmware/efi/rci2-table.c:92).
> 87              if (!rci2_base) {
> 88                      pr_debug("RCI2 table init failed - could not map RCI2 table\n");
> 89                      goto err;
> 90              }
> 91
> 92              if (strncmp(rci2_base +
> 93                          offsetof(struct rci2_table_global_hdr, rci2_sig),
> 94                          RCI_SIGNATURE, 4)) {
> 95                      pr_debug("RCI2 table init failed - incorrect signature\n");
> 96                      ret = -ENODEV;
>
> See also the attached `boot' file.
>
> [7.] A small shell script or example program which triggers the
>      problem (if possible)
> I tested with with the following command-line in order to capture the kernel
> messages:
> qemu-system-i386\
>         -enable-kvm\
>         -cpu n270\
>         -serial stdio\
>         -m 1G\
>         -kernel ---path-to-bzImage---\
>         -append console=ttyS0
>
> I set the cpu to n270, which I have in the real HW. With the default qemu-i386
> CPU the problem does *not* happen. I set the memory to 1G, that is what I have
> in the Acer Aspire One. I did *not* experiment with different memory settings.
>
> [8.] Environment
> [8.1.] Software (add the output of the ver_linux script here)
> I do not think that it is relevant, it gives only the settings for the host
> system where I ran the experiments with qemu.
>
> [8.2.] Processor information (from /proc/cpuinfo):
> The kernel does not boot, but it seems to be important that it is an Intel
> Atom N270.
>
> [8.3.] Module information (from /proc/modules):
> N/A
>
> [8.4.] Loaded driver and hardware information (/proc/ioports, /proc/iomem)
> N/A
>
> [8.5.] PCI information ('lspci -vvv' as root)
> N/A
>
> [8.6.] SCSI information (from /proc/scsi/scsi)
> N/A
>
> [8.7.] Other information that might be relevant to the problem
>        (please look in /proc and include all information that you
>        think to be relevant):
> N/A
>
> [X.] Other notes, patches, fixes, workarounds:
>
> This was the original error report on my distribution's discussion forum: `https://www.linuxquestions.org/questions/slackware-installation-40/slackware-current-kernel-panic-with-5-4-1-on-x86-4175665274/'.
> Two forum members in the thread confirmed the existence of the problem on real
> HW. You might also find comments in the thread interesting in general related
> to the problem. Comments also show that disabling e.g. EFI_RCI2 makes the
> oops not to appear on real HW.
>
> It very well might be that it does not even makes sense to set EFI_RCI2 on
> ARCH=i386 (as the config documentaton states it is meant only if you have a
> Dell EMC Server, which - I do not know - might be AMD64/Xeon), this, however,
> should then be enforced by the kernel config system. The problem, however,
> only seems to exist if EFI_RCI2 and HIHGHMEM64G and Intel Atom n270 - so it
> might be that those combinations make sense.
>
> Thanks,
> Chalapticus
