Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 026D8F985
	for <lists+linux-efi@lfdr.de>; Tue, 30 Apr 2019 15:07:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727670AbfD3NHZ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 30 Apr 2019 09:07:25 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:41419 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726264AbfD3NHZ (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 30 Apr 2019 09:07:25 -0400
Received: by mail-ed1-f65.google.com with SMTP id m4so12223518edd.8
        for <linux-efi@vger.kernel.org>; Tue, 30 Apr 2019 06:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=PuWqd/jfgEr1W1j24gCec2HIy4uW7W4M3VYk8SukP7M=;
        b=csMYXnhGwHK0VJzkQghz4oGDWFJQoQsxmiEzghA/tpZJOMQMhYFYam4+VIKdhr+zGW
         s/wHhmvBbz0kdeKeEYuFJf+w/0VG6qyrGDJuv9py2ccLCjnoan35lwOu0DE8FwadYmci
         h3KlMEgiuLzTQuLYbN9QfvM3iaUW7n+d1wQmV7FQ8NZaRG4n07xQppu+LOyJoKTukRuv
         gk6gML46qHEn47PJSar/w+Zm6K3Qh8JleVFtt90RPR+Bmnd716N6j1oDSdYRS4+lu6eB
         MU3Sl9wcCI7no+apOlV0PNZz4JTvIq7JiGf14VIdjpMf3rG0u0khiSh8nWJy6TW9bEKA
         cJnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=PuWqd/jfgEr1W1j24gCec2HIy4uW7W4M3VYk8SukP7M=;
        b=C1pfgMG+Q3xcLK4BMf5MhYDt+6w/fcY5VTGFxhqvEh1yKBfiw/0l/8te56oF87JWII
         qqXHiegrdrhnYiqqlQyHPfoyCLL3WN4Me+x+oTGIH8oi8U5fYG1eiWLqjiZkPHBtiVG3
         YQ9LCZi3u3K+j7JP2/t8AIOi1C2DeJQz2F/uUlOkzZUzJ4SEWzMzHDfagFxaVj3jD9E0
         7Nv2rwEIqpBh3Sjh68uV/SaFTtmzmEjho+DIRuXo7MA4s12sDuPr6A8/O3HQYd0t++mC
         mkUFEXHkvvuqLiIXEcnqyVj+4E6z13TFfm1dbA3DEfN+oYjXanekqssOkCv/bJVwrOHC
         iF3w==
X-Gm-Message-State: APjAAAVOs2jqY2Di0Iqx1kpp1wvSjB+/EWZSgnodQ6g66UIRhReLOfVL
        Q+C6VxL7uXwmL0Ey2nRRrUNjn/TxDAm5UHc/
X-Google-Smtp-Source: APXvYqwa9LqavRfXfQteDLzYKOgezU2nJJtJqNHUIfexvjgmyb53AJqMq6yAH0ehojNo8iUveiQSvg==
X-Received: by 2002:a17:906:1dd5:: with SMTP id v21mr4291557ejh.142.1556629642930;
        Tue, 30 Apr 2019 06:07:22 -0700 (PDT)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com. [209.85.221.41])
        by smtp.gmail.com with ESMTPSA id g6sm10091388edd.48.2019.04.30.06.07.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Apr 2019 06:07:21 -0700 (PDT)
Received: by mail-wr1-f41.google.com with SMTP id o4so9006343wra.3;
        Tue, 30 Apr 2019 06:07:21 -0700 (PDT)
X-Received: by 2002:a5d:6887:: with SMTP id h7mr8331733wru.110.1556629640707;
 Tue, 30 Apr 2019 06:07:20 -0700 (PDT)
MIME-Version: 1.0
References: <20190227202658.197113-1-matthewgarrett@google.com> <20190227202658.197113-3-matthewgarrett@google.com>
In-Reply-To: <20190227202658.197113-3-matthewgarrett@google.com>
From:   Bartosz Szczepanek <bsz@semihalf.com>
Date:   Tue, 30 Apr 2019 15:07:09 +0200
X-Gmail-Original-Message-ID: <CAJzaN5pUJoOCz5-ZDSnTb6dbVPuy0QwmFD0CeofAGK+bRQx0og@mail.gmail.com>
Message-ID: <CAJzaN5pUJoOCz5-ZDSnTb6dbVPuy0QwmFD0CeofAGK+bRQx0og@mail.gmail.com>
Subject: Re: [PATCH V5 2/4] tpm: Reserve the TPM final events table
To:     Matthew Garrett <matthewgarrett@google.com>
Cc:     linux-integrity@vger.kernel.org, peterhuewe@gmx.de,
        jarkko.sakkinen@linux.intel.com, jgg@ziepe.ca,
        roberto.sassu@huawei.com, linux-efi@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, tweek@google.com,
        Matthew Garrett <mjg59@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

I may be a little late with this comment, but I've just tested these
patches on aarch64 platform (from the top of jjs/master) and got
kernel panic ("Unable to handle kernel read", full log at the end of
mail). I think there's problem with below call to
tpm2_calc_event_log_size(), where physical address of efi.tpm_log is
passed as (void *) and never remapped:

> +       tbl_size =3D tpm2_calc_event_log_size(final_tbl->events,
> +                                           final_tbl->nr_events,
> +                                           (void *)efi.tpm_log);

This is later used to get efispecid:

>         efispecid =3D (struct tcg_efi_specid_event_head *)event_header->e=
vent;

It seems event_header is not mapped during dereference. This is
somewhat expected, because it comes from different, already unmapped
memory region (region of initial TPM log) than "event" itself (which
comes from TPM final log).

Also, value passed as size_info shouldn't be pointing to
linux_efi_tpm_eventlog with its size and version fields, but to the
first event (header event) within. I tried with log_tbl->log and it
worked fine (I omitted unmapping part). On the other hand, with bare
log_tbl it still fails. Not sure how does it even work on other
platforms.

One more thing that's not clear for me =E2=80=93 shouldn't the value return=
ed
from early_memremap be used for further accesses? Throughout
__calc_tpm2_event_size() "mapping" is only checked for being zero.
When it is, you're still unmapping it =E2=80=93 is it correct?

> +       while (count > 0) {
> +               header =3D data + size;
> +               event_size =3D __calc_tpm2_event_size(header, size_info, =
true);
> +               if (event_size =3D=3D 0)
> +                       return -1;
> +               size +=3D event_size;
> +       }

Loop condition here is always true, by the way.

One information about my setup =E2=80=93 I'm working with below local diff =
to
enable operation on ARM:
> --- a/drivers/firmware/efi/libstub/arm-stub.c
> +++ b/drivers/firmware/efi/libstub/arm-stub.c
> @@ -194,6 +194,7 @@ unsigned long efi_entry(void *handle, efi_system_tabl=
e_t *sys_table,
>
>       /* Ask the firmware to clear memory on unclean shutdown */
>        efi_enable_reset_attack_mitigation(sys_table);
> +       efi_retrieve_tpm2_eventlog(sys_table);

Full log of kernel panic follows.

EFI stub: Booting Linux Kernel...
EFI stub: EFI_RNG_PROTOCOL unavailable, no randomness supplied
EFI stub: Using DTB from configuration table
EFI stub: Exiting boot services and installing virtual address map...
[    0.000000] Booting Linux on physical CPU 0x0000000000 [0x420f5162]
[    0.000000] Linux version 5.1.0-rc2+ (root@localhost.localdomain)
(gcc version 7.3.1 20180712 (Red Hat 7.3.1-6) (GCC)) #69 SMP Fri Apr
26 03:20:57 EDT 2019
[    0.000000] earlycon: pl11 at MMIO 0x0000000402020000 (options '115200n8=
')
[    0.000000] printk: bootconsole [pl11] enabled
[    0.000000] efi: Getting EFI parameters from FDT:
[    0.000000] efi: EFI v2.60 by Cavium Inc.
TX2-FW-Release-7.2-build_08-0-g14f8c5bf8a Apr 15 2019 18:51:41
[    0.000000] efi:  TPMFinalLog=3D0xed5f0000  SMBIOS=3D0xfad90000  SMBIOS
3.0=3D0xed530000  ACPI 2.0=3D0xeda90000  ESRT=3D0xfafdb218
MEMATTR=3D0xf8489018  TPMEventLog=3D0xedaa9018  MEMRESERVE=3D0xedaa8018
[    0.000000] Unable to handle kernel read from unreadable memory at
virtual address 00000000edaa9050
[    0.000000] Mem abort info:
[    0.000000]   ESR =3D 0x96000004
[    0.000000]   Exception class =3D DABT (current EL), IL =3D 32 bits
[    0.000000]   SET =3D 0, FnV =3D 0
[    0.000000]   EA =3D 0, S1PTW =3D 0
[    0.000000] Data abort info:
[    0.000000]   ISV =3D 0, ISS =3D 0x00000004
[    0.000000]   CM =3D 0, WnR =3D 0
[    0.000000] [00000000edaa9050] user address but active_mm is swapper
[    0.000000] Internal error: Oops: 96000004 [#1] SMP
[    0.000000] Modules linked in:
[    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted 5.1.0-rc2+ #69
[    0.000000] pstate: 60400089 (nZCv daIf +PAN -UAO)
[    0.000000] pc : efi_tpm_eventlog_init+0xfc/0x26c
[    0.000000] lr : efi_tpm_eventlog_init+0xf4/0x26c
[    0.000000] sp : ffff000011533ce0
[    0.000000] x29: ffff000011533ce0 x28: 00000000edaa8018
[    0.000000] x27: ffff7dfffe6fa010 x26: 0000000000000023
[    0.000000] x25: ffff7dfffe6fa000 x24: 00000000edaa9038
[    0.000000] x23: 0000000000000000 x22: ffff7dfffe6fa010
[    0.000000] x21: ffff00001153d000 x20: ffff7dfffe6fa018
[    0.000000] x19: ffff000011542500 x18: ffffffffffffffff
[    0.000000] x17: 0000000000000435 x16: 0000000000000000
[    0.000000] x15: ffff00001153d708 x14: 6576454d50542020
[    0.000000] x13: 3831303938343866 x12: 78303d525454414d
[    0.000000] x11: 454d202038313262 x10: 6466616678303d54
[    0.000000] x9 : ffff00001153ef58 x8 : 0000020000000000
[    0.000000] x7 : 0000000000000a30 x6 : ffff0000110d2a18
[    0.000000] x5 : 000000000000013a x4 : 00000000000004c5
[    0.000000] x3 : ffff000011714000 x2 : 0000000000000002
[    0.000000] x1 : ffff7dfffe6fa000 x0 : ffff7dfffe73a010
[    0.000000] Process swapper (pid: 0, stack limit =3D 0x(____ptrval____))
[    0.000000] Call trace:
[    0.000000]  efi_tpm_eventlog_init+0xfc/0x26c
[    0.000000]  efi_config_parse_tables+0x180/0x29c
[    0.000000]  uefi_init+0x1d0/0x22c
[    0.000000]  efi_init+0x90/0x180
[    0.000000]  setup_arch+0x1f4/0x5fc
[    0.000000]  start_kernel+0x90/0x51c
[    0.000000] Code: aa1603e0 97ff05c7 b4000860 b9400ac2 (b9401b01)
[    0.000000] random: get_random_bytes called from
print_oops_end_marker+0x54/0x70 with crng_init=3D0
[    0.000000] ---[ end trace 0000000000000000 ]---
[    0.000000] Kernel panic - not syncing: Attempted to kill the idle task!
[    0.000000] ---[ end Kernel panic - not syncing: Attempted to kill
the idle task! ]---
