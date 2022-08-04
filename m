Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2DB3589BF4
	for <lists+linux-efi@lfdr.de>; Thu,  4 Aug 2022 14:54:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233576AbiHDMyO (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 4 Aug 2022 08:54:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230140AbiHDMyN (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 4 Aug 2022 08:54:13 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7B99D1EAD6
        for <linux-efi@vger.kernel.org>; Thu,  4 Aug 2022 05:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659617651;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=r8cUqWV2FlnkGBUrzcquRGXkxAAYXIIOSc8TFyfsxWg=;
        b=Xn9Y9XD01tBhNLJcQZa6kMZYkL5oisDBDb9o6mAjNiI9Yv+FdHGGqs/oyKdnqVnK35EPbl
        xqNiEZK0h5rUtcaWd+43Jf2qFtPZplPh9r6LtBnbp7CGXJs7veTJv02VqqpjK+0IVLHLyw
        GcFILcwE1n9JRJesWJL2VkaIaiwZ6kk=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-546-X4XHXgSVORaJy65x7AENfA-1; Thu, 04 Aug 2022 08:54:08 -0400
X-MC-Unique: X4XHXgSVORaJy65x7AENfA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 20FA3381A08B;
        Thu,  4 Aug 2022 12:54:08 +0000 (UTC)
Received: from redhat.com (unknown [10.33.36.223])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E49AE1121314;
        Thu,  4 Aug 2022 12:54:05 +0000 (UTC)
Date:   Thu, 4 Aug 2022 13:54:03 +0100
From:   Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     qemu-devel@nongnu.org, Xiaoyao Li <xiaoyao.li@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Richard Henderson <richard.henderson@linaro.org>,
        Peter Maydell <peter.maydell@linaro.org>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org
Subject: Re: [PATCH v2] hw/i386: place setup_data at fixed place in memory
Message-ID: <YuvBaxwcWPGvW0gZ@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <YusVVLNbLgsk49PK@zx2c4.com>
 <20220804004411.1343158-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220804004411.1343158-1-Jason@zx2c4.com>
User-Agent: Mutt/2.2.6 (2022-06-05)
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, Aug 04, 2022 at 02:44:11AM +0200, Jason A. Donenfeld wrote:
> The boot parameter header refers to setup_data at an absolute address,
> and each setup_data refers to the next setup_data at an absolute address
> too. Currently QEMU simply puts the setup_datas right after the kernel
> image, and since the kernel_image is loaded at prot_addr -- a fixed
> address knowable to QEMU apriori -- the setup_data absolute address
> winds up being just `prot_addr + a_fixed_offset_into_kernel_image`.
> 
> This mostly works fine, so long as the kernel image really is loaded at
> prot_addr. However, OVMF doesn't load the kernel at prot_addr, and
> generally EFI doesn't give a good way of predicting where it's going to
> load the kernel. So when it loads it at some address != prot_addr, the
> absolute addresses in setup_data now point somewhere bogus, causing
> crashes when EFI stub tries to follow the next link.
> 
> Fix this by placing setup_data at some fixed place in memory, relative
> to real_addr, not as part of the kernel image, and then pointing the
> setup_data absolute address to that fixed place in memory. This way,
> even if OVMF or other chains relocate the kernel image, the boot
> parameter still points to the correct absolute address.
> 
> Fixes: 3cbeb52467 ("hw/i386: add device tree support")
> Reported-by: Xiaoyao Li <xiaoyao.li@intel.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Richard Henderson <richard.henderson@linaro.org>
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Cc: Daniel P. Berrangé <berrange@redhat.com>
> Cc: Gerd Hoffmann <kraxel@redhat.com>
> Cc: Ard Biesheuvel <ardb@kernel.org>
> Cc: linux-efi@vger.kernel.org
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> ---
>  hw/i386/x86.c | 38 ++++++++++++++++++++------------------
>  1 file changed, 20 insertions(+), 18 deletions(-)
> 
> diff --git a/hw/i386/x86.c b/hw/i386/x86.c
> index 050eedc0c8..8b853abf38 100644
> --- a/hw/i386/x86.c
> +++ b/hw/i386/x86.c


>      if (!legacy_no_rng_seed) {
> -        setup_data_offset = QEMU_ALIGN_UP(kernel_size, 16);
> -        kernel_size = setup_data_offset + sizeof(struct setup_data) + RNG_SEED_LENGTH;
> -        kernel = g_realloc(kernel, kernel_size);
> -        setup_data = (struct setup_data *)(kernel + setup_data_offset);
> +        setup_data_item_len = sizeof(struct setup_data) + RNG_SEED_LENGTH;
> +        setup_datas = g_realloc(setup_datas, setup_data_total_len + setup_data_item_len);
> +        setup_data = (struct setup_data *)(setup_datas + setup_data_total_len);
>          setup_data->next = cpu_to_le64(first_setup_data);
> -        first_setup_data = prot_addr + setup_data_offset;
> +        first_setup_data = setup_data_base + setup_data_total_len;
> +        setup_data_total_len += setup_data_item_len;
>          setup_data->type = cpu_to_le32(SETUP_RNG_SEED);
>          setup_data->len = cpu_to_le32(RNG_SEED_LENGTH);
>          qemu_guest_getrandom_nofail(setup_data->data, RNG_SEED_LENGTH);
>      }
>  
> -    /* Offset 0x250 is a pointer to the first setup_data link. */
> -    stq_p(header + 0x250, first_setup_data);
> +    if (first_setup_data) {
> +            /* Offset 0x250 is a pointer to the first setup_data link. */
> +            stq_p(header + 0x250, first_setup_data);
> +            rom_add_blob("setup_data", setup_datas, setup_data_total_len, setup_data_total_len,
> +                         setup_data_base, NULL, NULL, NULL, NULL, false);
> +    }

The boot measurements with AMD SEV now succeed, but I'm a little
worried about the implications of adding this ROM, when a few lines
later here we're discarding the 'header' changes for AMD SEV. Is
this still going to operate correctly in the guest OS if we've
discarded the header changes below ?

>      /*
>       * If we're starting an encrypted VM, it will be OVMF based, which uses the
>       * efi stub for booting and doesn't require any values to be placed in the
>       * kernel header.  We therefore don't update the header so the hash of the
>       * kernel on the other side of the fw_cfg interface matches the hash of the
>       * file the user passed in.
>       */
>      if (!sev_enabled()) {
>          memcpy(setup, header, MIN(sizeof(header), setup_size));
>      }
>  
>      fw_cfg_add_i32(fw_cfg, FW_CFG_KERNEL_ADDR, prot_addr);
>      fw_cfg_add_i32(fw_cfg, FW_CFG_KERNEL_SIZE, kernel_size);
>      fw_cfg_add_bytes(fw_cfg, FW_CFG_KERNEL_DATA, kernel, kernel_size);
>      sev_load_ctx.kernel_data = (char *)kernel;
> -- 
> 2.35.1
> 
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|

