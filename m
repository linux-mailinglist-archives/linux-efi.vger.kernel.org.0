Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7935B29FCCD
	for <lists+linux-efi@lfdr.de>; Fri, 30 Oct 2020 05:46:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725790AbgJ3Eqe (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 30 Oct 2020 00:46:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:53976 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725771AbgJ3Eqd (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 30 Oct 2020 00:46:33 -0400
Received: from kernel.org (83-245-197-237.elisa-laajakaista.fi [83.245.197.237])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3171E2151B;
        Fri, 30 Oct 2020 04:46:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604033192;
        bh=13p3IyKG11EvWKvG7hOSytlGbbOiNTx5FXLmwvsxsMA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ESj5k8jp/W8+VhE+xDPRmI7VRyr23XwwlajHMg3n7iiAosC6b8SsWMDq/GlpO4PBm
         cGYcOzFRVYZJTFNcoJ4ioo4V9vXBUjs8OmEC2WO1JZUSha2CiPB2hMBbi9z1WhoIfC
         c5vxCXrX+4AUYNK0rl+9Xx8wWgbFLhodSdtArEws=
Date:   Fri, 30 Oct 2020 06:46:26 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Tyler Hicks <tyhicks@linux.microsoft.com>
Cc:     Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-efi@vger.kernel.org,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        "Kenneth R . Crudup" <kenny@panix.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        =?iso-8859-1?Q?Thi=E9baud?= Weksteen <tweek@google.com>,
        Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH] tpm: efi: Don't create binary_bios_measurements file for
 an empty log
Message-ID: <20201030044626.GA36779@kernel.org>
References: <E1FDCCCB-CA51-4AEE-AC83-9CDE995EAE52@canonical.com>
 <20201028154102.9595-1-tyhicks@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201028154102.9595-1-tyhicks@linux.microsoft.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Oct 28, 2020 at 10:41:02AM -0500, Tyler Hicks wrote:
> Mimic the pre-existing ACPI and Device Tree event log behavior by not
> creating the binary_bios_measurements file when the EFI TPM event log is
> empty.
> 
> This fixes the following NULL pointer dereference that can occur when
> reading /sys/kernel/security/tpm0/binary_bios_measurements after the
> kernel received an empty event log from the firmware:
> 
>  BUG: kernel NULL pointer dereference, address: 000000000000002c
>  #PF: supervisor read access in kernel mode
>  #PF: error_code(0x0000) - not-present page
>  PGD 0 P4D 0
>  Oops: 0000 [#1] SMP PTI
>  CPU: 2 PID: 3932 Comm: fwupdtpmevlog Not tainted 5.9.0-00003-g629990edad62 #17
>  Hardware name: LENOVO 20LCS03L00/20LCS03L00, BIOS N27ET38W (1.24 ) 11/28/2019
>  RIP: 0010:tpm2_bios_measurements_start+0x3a/0x550
>  Code: 54 53 48 83 ec 68 48 8b 57 70 48 8b 1e 65 48 8b 04 25 28 00 00 00 48 89 45 d0 31 c0 48 8b 82 c0 06 00 00 48 8b 8a c8 06 00 00 <44> 8b 60 1c 48 89 4d a0 4c 89 e2 49 83 c4 20 48 83 fb 00 75 2a 49
>  RSP: 0018:ffffa9c901203db0 EFLAGS: 00010246
>  RAX: 0000000000000010 RBX: 0000000000000000 RCX: 0000000000000010
>  RDX: ffff8ba1eb99c000 RSI: ffff8ba1e4ce8280 RDI: ffff8ba1e4ce8258
>  RBP: ffffa9c901203e40 R08: ffffa9c901203dd8 R09: ffff8ba1ec443300
>  R10: ffffa9c901203e50 R11: 0000000000000000 R12: ffff8ba1e4ce8280
>  R13: ffffa9c901203ef0 R14: ffffa9c901203ef0 R15: ffff8ba1e4ce8258
>  FS:  00007f6595460880(0000) GS:ffff8ba1ef880000(0000) knlGS:0000000000000000
>  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>  CR2: 000000000000002c CR3: 00000007d8d18003 CR4: 00000000003706e0
>  DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>  DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>  Call Trace:
>   ? __kmalloc_node+0x113/0x320
>   ? kvmalloc_node+0x31/0x80
>   seq_read+0x94/0x420
>   vfs_read+0xa7/0x190
>   ksys_read+0xa7/0xe0
>   __x64_sys_read+0x1a/0x20
>   do_syscall_64+0x37/0x80
>   entry_SYSCALL_64_after_hwframe+0x44/0xa9
> 
> In this situation, the bios_event_log pointer in the tpm_bios_log struct
> was not NULL but was equal to the ZERO_SIZE_PTR (0x10) value. This was
> due to the following kmemdup() in tpm_read_log_efi():
> 
> int tpm_read_log_efi(struct tpm_chip *chip)
> {
> ...
> 	/* malloc EventLog space */
> 	log->bios_event_log = kmemdup(log_tbl->log, log_size, GFP_KERNEL);
> 	if (!log->bios_event_log) {
> 		ret = -ENOMEM;
> 		goto out;
> 	}
> ...
> }
> 
> When log_size is zero, due to an empty event log from firmware,
> ZERO_SIZE_PTR is returned from kmemdup(). Upon a read of the
> binary_bios_measurements file, the tpm2_bios_measurements_start()
> function does not perform a ZERO_OR_NULL_PTR() check on the
> bios_event_log pointer before dereferencing it.
> 
> Rather than add a ZERO_OR_NULL_PTR() check in functions that make use of
> the bios_event_log pointer, simply avoid creating the
> binary_bios_measurements_file as is done in other event log retrieval
> backends.
> 
> Explicitly ignore all of the events in the final event log when the main
> event log is empty. The list of events in the final event log cannot be
> accurately parsed without referring to the first event in the main event
> log (the event log header) so the final event log is useless in such a
> situation.
> 
> Fixes: 58cc1e4faf10 ("tpm: parse TPM event logs based on EFI table")
> Link: https://lore.kernel.org/linux-integrity/E1FDCCCB-CA51-4AEE-AC83-9CDE995EAE52@canonical.com/
> Reported-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> Reported-by: Kenneth R. Crudup <kenny@panix.com>
> Reported-by: Mimi Zohar <zohar@linux.ibm.com>
> Cc: Thiébaud Weksteen <tweek@google.com>
> Cc: Ard Biesheuvel <ardb@kernel.org>
> Signed-off-by: Tyler Hicks <tyhicks@linux.microsoft.com>
> ---

Applied, thanks.

>  drivers/char/tpm/eventlog/efi.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/char/tpm/eventlog/efi.c b/drivers/char/tpm/eventlog/efi.c
> index 6bb023de17f1..35229e5143ca 100644
> --- a/drivers/char/tpm/eventlog/efi.c
> +++ b/drivers/char/tpm/eventlog/efi.c
> @@ -41,6 +41,11 @@ int tpm_read_log_efi(struct tpm_chip *chip)
>  	log_size = log_tbl->size;
>  	memunmap(log_tbl);
>  
> +	if (!log_size) {
> +		pr_warn("UEFI TPM log area empty\n");
> +		return -EIO;
> +	}
> +
>  	log_tbl = memremap(efi.tpm_log, sizeof(*log_tbl) + log_size,
>  			   MEMREMAP_WB);
>  	if (!log_tbl) {
> 
> base-commit: ed8780e3f2ecc82645342d070c6b4e530532e680
> -- 
> 2.25.1
> 
> 

/Jarkko
