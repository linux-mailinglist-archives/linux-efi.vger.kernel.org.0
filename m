Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5033C60728E
	for <lists+linux-efi@lfdr.de>; Fri, 21 Oct 2022 10:39:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230203AbiJUIjL (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 21 Oct 2022 04:39:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230262AbiJUIjK (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 21 Oct 2022 04:39:10 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1D17246C37
        for <linux-efi@vger.kernel.org>; Fri, 21 Oct 2022 01:39:05 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id r22so2713676ljn.10
        for <linux-efi@vger.kernel.org>; Fri, 21 Oct 2022 01:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iAHuOppwDGaKnT10vJP0fUSdL9GqH7XWASP6q3EvVQM=;
        b=DxBLdMDzHJthVziw5dFWbhcNGEN89uziZaHlmX837S643SMUJw+LwpwHAS0Ip9xnRU
         jOIJUbFpDfATb3aPOYarIOlU9IeeZFLcuIplQ3JicvHHDsjq0omMoQYSkA+dtC3SJh0V
         SEmhHvW+CaARLWLha8Gd+Lc16Z4vouDFRl/eez4oq+HpfBCqfmZT3jE9pspyP5svIb4A
         OkLgLpPzjJ619QSqvgYqFCrjANUcChJY7Mqd4GhO+6bV5N7qsgrfStf4n5mfUe+tbSvn
         zXU1MdcoA/P4DoVdpEXPQyjiR81aZ7EKU+Xc0Yk3p+zS1BacDZxe18wFJyuS2YPSWQUU
         Zy3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iAHuOppwDGaKnT10vJP0fUSdL9GqH7XWASP6q3EvVQM=;
        b=TlCztkNlQ15E3EG6fI9g5dui+8sIFzUTeLNof7maGUuM2JCCxest1EBQxeoaQDgcJQ
         qTZQiixXxZvsBxS170TqITUb08oyZRVgHKzUWeD9KMOK0TQFv3Xx4A2SUrKJr9Pbe5b7
         w930tQt5vn3w8HDhEhWAjixCn2iiEb+oj43ahZBX+hQfG/5SDJivmx4r5BlJKyRl+FwJ
         NuPKlBljEFPM8YHBp6YNixgFHHPs/APti/QVUqieA66dYqO8dfdmd6cnOgWSGywMvlSC
         XVUo3lLMZChJAeIkcw8rEzBX83RWxYtZHAuRrExa7Y4aWRuMijbxQjJeqCBWK+yKlj1S
         be6w==
X-Gm-Message-State: ACrzQf0i9Tr58m6u+i/PXwnj5/Df14jQmHlFkVNdw6TFQqk7aUwcgKM9
        qu2lbkiCKB6JtqRUd0edy5TfVwKWoCKJEA==
X-Google-Smtp-Source: AMsMyM6BxGIomkS4VHWtfDyaUhbo6HTLH/qwCvirNCuHaGe2ieQlR8PCAGVV1wJvSR+BX51NIwlwrA==
X-Received: by 2002:a17:907:1c86:b0:78d:b8dd:4826 with SMTP id nb6-20020a1709071c8600b0078db8dd4826mr14417728ejc.492.1666341533578;
        Fri, 21 Oct 2022 01:38:53 -0700 (PDT)
Received: from hades (ppp046103015185.access.hol.gr. [46.103.15.185])
        by smtp.gmail.com with ESMTPSA id f20-20020a17090631d400b0073de0506745sm11261884ejf.197.2022.10.21.01.38.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 01:38:53 -0700 (PDT)
Date:   Fri, 21 Oct 2022 11:38:50 +0300
From:   Ilias Apalodimas <ilias.apalodimas@linaro.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, "Jason A . Donenfeld" <Jason@zx2c4.com>,
        Lennart Poettering <lennart@poettering.net>,
        stable@vger.kernel.org
Subject: Re: [PATCH v3 1/3] efi: random: reduce seed size to 32 bytes
Message-ID: <Y1JamhzEq5JQlWhQ@hades>
References: <20221020083910.1902009-1-ardb@kernel.org>
 <20221020083910.1902009-2-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221020083910.1902009-2-ardb@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, Oct 20, 2022 at 10:39:08AM +0200, Ard Biesheuvel wrote:
> We no longer need at least 64 bytes of random seed to permit the early
> crng init to complete. The RNG is now based on Blake2s, so reduce the
> EFI seed size to the Blake2s hash size, which is sufficient for our
> purposes.
> 
> While at it, drop the READ_ONCE(), which was supposed to prevent size
> from being evaluated after seed was unmapped. However, this cannot
> actually happen, so READ_ONCE() is unnecessary here.
> 
> Cc: <stable@vger.kernel.org> # v4.14+
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> Reviewed-by: Jason A. Donenfeld <Jason@zx2c4.com>
> ---
>  drivers/firmware/efi/efi.c | 2 +-
>  include/linux/efi.h        | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
> index 9624735f1575..a949509de62f 100644
> --- a/drivers/firmware/efi/efi.c
> +++ b/drivers/firmware/efi/efi.c
> @@ -609,7 +609,7 @@ int __init efi_config_parse_tables(const efi_config_table_t *config_tables,
>  
>  		seed = early_memremap(efi_rng_seed, sizeof(*seed));
>  		if (seed != NULL) {
> -			size = READ_ONCE(seed->size);
> +			size = min(seed->size, EFI_RANDOM_SEED_SIZE);
>  			early_memunmap(seed, sizeof(*seed));
>  		} else {
>  			pr_err("Could not map UEFI random seed!\n");
> diff --git a/include/linux/efi.h b/include/linux/efi.h
> index da3974bf05d3..cf96f8d5f15f 100644
> --- a/include/linux/efi.h
> +++ b/include/linux/efi.h
> @@ -1225,7 +1225,7 @@ efi_status_t efi_random_get_seed(void);
>  	arch_efi_call_virt_teardown();					\
>  })
>  
> -#define EFI_RANDOM_SEED_SIZE		64U
> +#define EFI_RANDOM_SEED_SIZE		32U // BLAKE2S_HASH_SIZE
>  
>  struct linux_efi_random_seed {
>  	u32	size;
> -- 
> 2.35.1
> 

Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

