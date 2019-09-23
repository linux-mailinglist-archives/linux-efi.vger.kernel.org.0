Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8B2DBBB730
	for <lists+linux-efi@lfdr.de>; Mon, 23 Sep 2019 16:52:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440123AbfIWOwr (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 23 Sep 2019 10:52:47 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:46032 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729070AbfIWOwp (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 23 Sep 2019 10:52:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1569250364;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fnHfrwRyFSd2mBHPfngqJTHWBoEaUqDVG4Gba3U6g+U=;
        b=Do2fPI3+FqKiL4L/7yXEZH4dvqCFj1l7Sdf2xCxRhvfigUsmbB+8yCJmHq/zWLLkJ1PC5/
        3Qg/+I6sF1srQlJ57zWulUuU/Q49/XNIxlZ0V1ErFaTo6mLdzDS16EVRysZI/J34fOJDeG
        J0UEENhjjczkxswVQsL6ispt+gvwu58=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-353--LMmYrn2N1G2w7rBGUq-Pg-1; Mon, 23 Sep 2019 10:52:43 -0400
Received: by mail-qt1-f199.google.com with SMTP id p56so17612995qtj.14
        for <linux-efi@vger.kernel.org>; Mon, 23 Sep 2019 07:52:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HyYCw9JIb/UV+poKSr0mrWc69vO3WXi731SqVUGI+ds=;
        b=Up6IsNKOvnwkhGrP6XBSPB9HJicRIxAXcLIVXt+OtSvYfpsLN2b4yCp+694EkNxdZo
         WeusY4m6bS3wkw6Ccqg3m24ZJ/x2rhKUYBLOPPBtPmli2dSgzunN07iShmdije2wG+lA
         MemFCd6J0ltKtCXtWmbj08S2zTUOP8YQ8GRNRo8JuuqLhZc4s12+vNtfmBc3xy5omrUA
         iytwSCIGJErKh/NBVv8AHNiFlkwQYwzELrfTE8n7dXg7wJnjSF+EcCxOasDkS256dWOd
         qixNS+k3D78MUZ6PRFJipHyyOLrs32+KfhdDfvjaNfUULdiJKTI5P5lniwgwJzMIEf+V
         DzdA==
X-Gm-Message-State: APjAAAXU9gtBLvDGX5QzpKt6GHSYSydQc5wahLN9gARRvnda6AuPefO7
        Twho+43Qmb+DXMKVTAI87kU00ZAysgaXA9T7EV46tAGqU8Fs04V9LyuJynTB99XcNmeezAkmufR
        0kV77ynYeVoF+3gvGfPrm
X-Received: by 2002:aed:316d:: with SMTP id 100mr352072qtg.20.1569250362075;
        Mon, 23 Sep 2019 07:52:42 -0700 (PDT)
X-Google-Smtp-Source: APXvYqz4/W3quyXwK9HwWEc6/h7kEcQ+0gurZ+pNMvwsCcHB/s74lngliKngPT7jor3HtKa4bVBTRQ==
X-Received: by 2002:aed:316d:: with SMTP id 100mr352046qtg.20.1569250361730;
        Mon, 23 Sep 2019 07:52:41 -0700 (PDT)
Received: from [192.168.1.157] (pool-96-235-39-235.pitbpa.fios.verizon.net. [96.235.39.235])
        by smtp.gmail.com with ESMTPSA id z141sm5575608qka.126.2019.09.23.07.52.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Sep 2019 07:52:40 -0700 (PDT)
Subject: Re: [RFC PATCH] tpm: only set efi_tpm_final_log_size after successful
 event log parsing
To:     linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        Matthew Garrett <mjg59@google.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
References: <20190918191626.5741-1-jsnitsel@redhat.com>
 <20190918192355.bzsv7ct5nmtrv5nu@cantor>
From:   Laura Abbott <labbott@redhat.com>
Message-ID: <e781bf52-0ffb-23bb-2ce6-f298d7545731@redhat.com>
Date:   Mon, 23 Sep 2019 10:52:40 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190918192355.bzsv7ct5nmtrv5nu@cantor>
Content-Language: en-US
X-MC-Unique: -LMmYrn2N1G2w7rBGUq-Pg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 9/18/19 8:23 PM, Jerry Snitselaar wrote:
> On Wed Sep 18 19, Jerry Snitselaar wrote:
>> If __calc_tpm2_event_size fails to parse an event it will return 0,
>> resulting tpm2_calc_event_log_size returning -1. Currently
>> there is no check of this return value, and efi_tpm_final_log_size
>> can end up being set to this negative value resulting
>> in a panic like the following:
>>
>> [=A0=A0=A0 0.774340] BUG: unable to handle page fault for address: ffffb=
c8fc00866ad
>> [=A0=A0=A0 0.774788] #PF: supervisor read access in kernel mode
>> [=A0=A0=A0 0.774788] #PF: error_code(0x0000) - not-present page
>> [=A0=A0=A0 0.774788] PGD 107d36067 P4D 107d36067 PUD 107d37067 PMD 107d3=
8067 PTE 0
>> [=A0=A0=A0 0.774788] Oops: 0000 [#1] SMP PTI
>> [=A0=A0=A0 0.774788] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.3.0-0.r=
c2.1.elrdy.x86_64 #1
>> [=A0=A0=A0 0.774788] Hardware name: LENOVO 20HGS22D0W/20HGS22D0W, BIOS N=
1WET51W (1.30 ) 09/14/2018
>> [=A0=A0=A0 0.774788] RIP: 0010:memcpy_erms+0x6/0x10
>> [=A0=A0=A0 0.774788] Code: 90 90 90 90 eb 1e 0f 1f 00 48 89 f8 48 89 d1 =
48 c1 e9 03 83 e2 07 f3 48 a5 89 d1 f3 a4 c3 66 0f 1f 44 00 00 48 89 f8 48 =
89 d1 <f3> a4 c3 0f 1f 80 00 00 00 00 48 89 f8 48 83 fa 20 72 7e 40 38 fe
>> [=A0=A0=A0 0.774788] RSP: 0000:ffffbc8fc0073b30 EFLAGS: 00010286
>> [=A0=A0=A0 0.774788] RAX: ffff9b1fc7c5b367 RBX: ffff9b1fc8390000 RCX: ff=
ffffffffffe962
>> [=A0=A0=A0 0.774788] RDX: ffffffffffffe962 RSI: ffffbc8fc00866ad RDI: ff=
ff9b1fc7c5b367
>> [=A0=A0=A0 0.774788] RBP: ffff9b1c10ca7018 R08: ffffbc8fc0085fff R09: 80=
00000000000063
>> [=A0=A0=A0 0.774788] R10: 0000000000001000 R11: 000fffffffe00000 R12: 00=
00000000003367
>> [=A0=A0=A0 0.774788] R13: ffff9b1fcc47c010 R14: ffffbc8fc0085000 R15: 00=
00000000000002
>> [=A0=A0=A0 0.774788] FS:=A0 0000000000000000(0000) GS:ffff9b1fce200000(0=
000) knlGS:0000000000000000
>> [=A0=A0=A0 0.774788] CS:=A0 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> [=A0=A0=A0 0.774788] CR2: ffffbc8fc00866ad CR3: 000000029f60a001 CR4: 00=
000000003606f0
>> [=A0=A0=A0 0.774788] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 00=
00000000000000
>> [=A0=A0=A0 0.774788] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 00=
00000000000400
>> [=A0=A0=A0 0.774788] Call Trace:
>> [=A0=A0=A0 0.774788]=A0 tpm_read_log_efi+0x156/0x1a0
>> [=A0=A0=A0 0.774788]=A0 tpm_bios_log_setup+0xc8/0x190
>> [=A0=A0=A0 0.774788]=A0 tpm_chip_register+0x50/0x1c0
>> [=A0=A0=A0 0.774788]=A0 tpm_tis_core_init.cold.9+0x28c/0x466
>> [=A0=A0=A0 0.774788]=A0 tpm_tis_plat_probe+0xcc/0xea
>> [=A0=A0=A0 0.774788]=A0 platform_drv_probe+0x35/0x80
>> [=A0=A0=A0 0.774788]=A0 really_probe+0xef/0x390
>> [=A0=A0=A0 0.774788]=A0 driver_probe_device+0xb4/0x100
>> [=A0=A0=A0 0.774788]=A0 device_driver_attach+0x4f/0x60
>> [=A0=A0=A0 0.774788]=A0 __driver_attach+0x86/0x140
>> [=A0=A0=A0 0.774788]=A0 ? device_driver_attach+0x60/0x60
>> [=A0=A0=A0 0.774788]=A0 bus_for_each_dev+0x76/0xc0
>> [=A0=A0=A0 0.774788]=A0 ? klist_add_tail+0x3b/0x70
>> [=A0=A0=A0 0.774788]=A0 bus_add_driver+0x14a/0x1e0
>> [=A0=A0=A0 0.774788]=A0 ? tpm_init+0xea/0xea
>> [=A0=A0=A0 0.774788]=A0 ? do_early_param+0x8e/0x8e
>> [=A0=A0=A0 0.774788]=A0 driver_register+0x6b/0xb0
>> [=A0=A0=A0 0.774788]=A0 ? tpm_init+0xea/0xea
>> [=A0=A0=A0 0.774788]=A0 init_tis+0x86/0xd8
>> [=A0=A0=A0 0.774788]=A0 ? do_early_param+0x8e/0x8e
>> [=A0=A0=A0 0.774788]=A0 ? driver_register+0x94/0xb0
>> [=A0=A0=A0 0.774788]=A0 do_one_initcall+0x46/0x1e4
>> [=A0=A0=A0 0.774788]=A0 ? do_early_param+0x8e/0x8e
>> [=A0=A0=A0 0.774788]=A0 kernel_init_freeable+0x199/0x242
>> [=A0=A0=A0 0.774788]=A0 ? rest_init+0xaa/0xaa
>> [=A0=A0=A0 0.774788]=A0 kernel_init+0xa/0x106
>> [=A0=A0=A0 0.774788]=A0 ret_from_fork+0x35/0x40
>> [=A0=A0=A0 0.774788] Modules linked in:
>> [=A0=A0=A0 0.774788] CR2: ffffbc8fc00866ad
>> [=A0=A0=A0 0.774788] ---[ end trace 42930799f8d6eaea ]---
>> [=A0=A0=A0 0.774788] RIP: 0010:memcpy_erms+0x6/0x10
>> [=A0=A0=A0 0.774788] Code: 90 90 90 90 eb 1e 0f 1f 00 48 89 f8 48 89 d1 =
48 c1 e9 03 83 e2 07 f3 48 a5 89 d1 f3 a4 c3 66 0f 1f 44 00 00 48 89 f8 48 =
89 d1 <f3> a4 c3 0f 1f 80 00 00 00 00 48 89 f8 48 83 fa 20 72 7e 40 38 fe
>> [=A0=A0=A0 0.774788] RSP: 0000:ffffbc8fc0073b30 EFLAGS: 00010286
>> [=A0=A0=A0 0.774788] RAX: ffff9b1fc7c5b367 RBX: ffff9b1fc8390000 RCX: ff=
ffffffffffe962
>> [=A0=A0=A0 0.774788] RDX: ffffffffffffe962 RSI: ffffbc8fc00866ad RDI: ff=
ff9b1fc7c5b367
>> [=A0=A0=A0 0.774788] RBP: ffff9b1c10ca7018 R08: ffffbc8fc0085fff R09: 80=
00000000000063
>> [=A0=A0=A0 0.774788] R10: 0000000000001000 R11: 000fffffffe00000 R12: 00=
00000000003367
>> [=A0=A0=A0 0.774788] R13: ffff9b1fcc47c010 R14: ffffbc8fc0085000 R15: 00=
00000000000002
>> [=A0=A0=A0 0.774788] FS:=A0 0000000000000000(0000) GS:ffff9b1fce200000(0=
000) knlGS:0000000000000000
>> [=A0=A0=A0 0.774788] CS:=A0 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> [=A0=A0=A0 0.774788] CR2: ffffbc8fc00866ad CR3: 000000029f60a001 CR4: 00=
000000003606f0
>> [=A0=A0=A0 0.774788] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 00=
00000000000000
>> [=A0=A0=A0 0.774788] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 00=
00000000000400
>> [=A0=A0=A0 0.774788] Kernel panic - not syncing: Fatal exception
>> [=A0=A0=A0 0.774788] Kernel Offset: 0x1d000000 from 0xffffffff81000000 (=
relocation range: 0xffffffff80000000-0xffffffffbfffffff)
>> [=A0=A0=A0 0.774788] ---[ end Kernel panic - not syncing: Fatal exceptio=
n ]---
>>
>> Fixes: c46f3405692de ("tpm: Reserve the TPM final events table")
>> Cc: Matthew Garrett <mjg59@google.com>
>> Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>> Cc: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
>> Signed-off-by: Jerry Snitselaar <jsnitsel@redhat.com>
>> ---
>> drivers/firmware/efi/tpm.c | 11 ++++++++---
>> 1 file changed, 8 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/firmware/efi/tpm.c b/drivers/firmware/efi/tpm.c
>> index 1d3f5ca3eaaf..5cd00a7833c2 100644
>> --- a/drivers/firmware/efi/tpm.c
>> +++ b/drivers/firmware/efi/tpm.c
>> @@ -40,8 +40,7 @@ int __init efi_tpm_eventlog_init(void)
>> {
>> =A0=A0=A0=A0struct linux_efi_tpm_eventlog *log_tbl;
>> =A0=A0=A0=A0struct efi_tcg2_final_events_table *final_tbl;
>> -=A0=A0=A0 unsigned int tbl_size;
>> -=A0=A0=A0 int ret =3D 0;
>> +=A0=A0=A0 int tbl_size, ret =3D 0;
>>
>> =A0=A0=A0=A0if (efi.tpm_log =3D=3D EFI_INVALID_TABLE_ADDR) {
>> =A0=A0=A0=A0=A0=A0=A0 /*
>> @@ -80,11 +79,17 @@ int __init efi_tpm_eventlog_init(void)
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 + =
sizeof(final_tbl->nr_events),
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 fi=
nal_tbl->nr_events,
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 lo=
g_tbl->log);
>> +=A0=A0=A0 if (tbl_size < 0) {
>> +=A0=A0=A0=A0=A0=A0=A0 pr_err("Failed to parse event in TPM Final Event =
log\n");
>> +=A0=A0=A0=A0=A0=A0=A0 goto calc_out;
>> +=A0=A0=A0 }
>> +
>> =A0=A0=A0=A0memblock_reserve((unsigned long)final_tbl,
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 tbl_size + sizeof(*final_tbl));
>> -=A0=A0=A0 early_memunmap(final_tbl, sizeof(*final_tbl));
>> =A0=A0=A0=A0efi_tpm_final_log_size =3D tbl_size;
>>
>> +calc_out:
>> +=A0=A0=A0 early_memunmap(final_tbl, sizeof(*final_tbl));
>> out:
>> =A0=A0=A0=A0early_memunmap(log_tbl, sizeof(*log_tbl));
>> =A0=A0=A0=A0return ret;
>> --=20
>> 2.23.0
>>
>=20
> I'm not sure what to set ret to, which currently isn't checked, or if any=
thing
> should be done with efi.tpm_final_log.
>=20

fwiw, this is being hit by a number of Fedora users
https://bugzilla.redhat.com/show_bug.cgi?id=3D1752961
I'd like to bring this patch to Fedora if there's general agreement
this is the correct approach.

Thanks,
Laura

