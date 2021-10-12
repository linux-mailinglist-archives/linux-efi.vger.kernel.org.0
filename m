Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 929B042A03E
	for <lists+linux-efi@lfdr.de>; Tue, 12 Oct 2021 10:47:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235317AbhJLItP (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 12 Oct 2021 04:49:15 -0400
Received: from isilmar-4.linta.de ([136.243.71.142]:43408 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235263AbhJLItO (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 12 Oct 2021 04:49:14 -0400
X-Greylist: delayed 392 seconds by postgrey-1.27 at vger.kernel.org; Tue, 12 Oct 2021 04:49:13 EDT
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
Received: from light.dominikbrodowski.net (brodo.linta [10.2.0.102])
        by isilmar-4.linta.de (Postfix) with ESMTPSA id 96AB52000BB;
        Tue, 12 Oct 2021 08:40:38 +0000 (UTC)
Received: by light.dominikbrodowski.net (Postfix, from userid 1000)
        id 3898A206D1; Tue, 12 Oct 2021 10:40:34 +0200 (CEST)
Date:   Tue, 12 Oct 2021 10:40:34 +0200
From:   Dominik Brodowski <linux@dominikbrodowski.net>
To:     "Ivan T. Ivanov" <iivanov@suse.de>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Bhupesh Sharma <bhsharma@redhat.com>,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Revert "efi/random: Treat EFI_RNG_PROTOCOL output as
 bootloader randomness"
Message-ID: <YWVKAk4h5bsUA3b6@light.dominikbrodowski.net>
References: <20211012082708.121931-1-iivanov@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211012082708.121931-1-iivanov@suse.de>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Am Tue, Oct 12, 2021 at 11:27:08AM +0300 schrieb Ivan T. Ivanov:
> This reverts commit 18b915ac6b0ac5ba7ded03156860f60a9f16df2b.
> 
> When CONFIG_RANDOM_TRUST_BOOTLOADER is enabled add_bootloader_randomness()
> calls add_hwgenerator_randomness() which might sleep,

Wouldn't it be better to fix add_bootloader_randomness(), considering that
calls to that function are likely to happen quite early during kernel
initialization? Especially as it seems to have worked beforehand?

Thanks,
	Dominik

> but this is not
> possible during early kernel initialization. This revert fixes following
> NULL pointer deference:
> 
> [    0.000000] efi: seeding entropy pool
> [    0.000000] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000000
> ...
> [    0.000000] pc : kthread_should_stop+0x2c/0x60
> [    0.000000] lr : add_hwgenerator_randomness+0x58/0x178
> ...
> [    0.000000] Call trace:
> [    0.000000]  kthread_should_stop+0x2c/0x60
> [    0.000000]  add_bootloader_randomness+0x2c/0x38
> [    0.000000]  efi_config_parse_tables+0x120/0x250
> [    0.000000]  efi_init+0x138/0x1e0
> [    0.000000]  setup_arch+0x394/0x778
> [    0.000000]  start_kernel+0x90/0x568
> 
> Signed-off-by: Ivan T. Ivanov <iivanov@suse.de>
> ---
>  drivers/firmware/efi/efi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
> index 847f33ffc4ae..8aad3c524947 100644
> --- a/drivers/firmware/efi/efi.c
> +++ b/drivers/firmware/efi/efi.c
> @@ -600,7 +600,7 @@ int __init efi_config_parse_tables(const efi_config_table_t *config_tables,
>  					      sizeof(*seed) + size);
>  			if (seed != NULL) {
>  				pr_notice("seeding entropy pool\n");
> -				add_bootloader_randomness(seed->bits, size);
> +				add_device_randomness(seed->bits, size);
>  				early_memunmap(seed, sizeof(*seed) + size);
>  			} else {
>  				pr_err("Could not map UEFI random seed!\n");
> -- 
> 2.33.0
> 
