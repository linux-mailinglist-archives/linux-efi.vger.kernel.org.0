Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 468534ACBAE
	for <lists+linux-efi@lfdr.de>; Mon,  7 Feb 2022 22:56:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243125AbiBGV4R (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 7 Feb 2022 16:56:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235933AbiBGV4Q (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 7 Feb 2022 16:56:16 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A194EC061355
        for <linux-efi@vger.kernel.org>; Mon,  7 Feb 2022 13:56:15 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id u130so15374376pfc.2
        for <linux-efi@vger.kernel.org>; Mon, 07 Feb 2022 13:56:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tHxa2zKVaHBcu/brPJMMDCzteRvMa8lCYhxJZN7g04o=;
        b=I3T0MgX3KD3D8din9AD4VmFgX5xNMlWkCITEwL0yWT4rotEFC5G/eY54wJX+04On6C
         CHr+Fk8wpO7RGMsRViMvJA3/won/IUNX8Ak9LBq8aIS1CJfPR5C6w46zR1Z8O+YPMarK
         I3WWGlNHdYu4PYfMgfgnwpeTxftKTY5LuLmhc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tHxa2zKVaHBcu/brPJMMDCzteRvMa8lCYhxJZN7g04o=;
        b=BdGoFbQSGDBsmR4tCBvTZsYOUe/kXPgiOXvYpZD4zgVx+8OQKtqqBJSKDXh/4M1fvg
         eIb4MTtAkAnyB/y5R1cMn+sebHCrVNAa6WBMEjO9lLg7TVFfvuBlMcCx7v3c8Frvqwh0
         yx7uAZYeTbRa4wUL+OcjWfWVIGoc/LlfTWslo0SNt5rC4Ga388/IziOnVv6wFeBw4Yq5
         08YKspMTK7pAKh0DxLwBH1vGo4g1F8vtYOs1c24Y9/nqmomtYsh6nJhhKtmshbYeWemX
         fJQzP3Hxnn2gajXFxuX9ZzdPitXZFhwYI7doCQx42lQjzq2bs46ubHmEo0Ph33qESsjX
         xt8w==
X-Gm-Message-State: AOAM531vEpPvHtWUPxuOCP2GvfCfKJgliMIWUGZTUN5JFlXv+kaJcl1N
        ZwAtWNfyAOPqw++Ou7gb8MEfFQ==
X-Google-Smtp-Source: ABdhPJyCMZS8k4XqgP2140WPRUddkLLGFWtx/egtokuBNm31gkdMHe+p42tk+Kmo6pOth6YVBsHvXw==
X-Received: by 2002:a63:4f4f:: with SMTP id p15mr1109735pgl.452.1644270975192;
        Mon, 07 Feb 2022 13:56:15 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 6sm9348292pgx.36.2022.02.07.13.56.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Feb 2022 13:56:14 -0800 (PST)
Date:   Mon, 7 Feb 2022 13:56:14 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Martin Fernandez <martin.fernandez@eclypsium.com>
Cc:     linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-mm@kvack.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        ardb@kernel.org, dvhart@infradead.org, andy@infradead.org,
        gregkh@linuxfoundation.org, rafael@kernel.org, rppt@kernel.org,
        akpm@linux-foundation.org, daniel.gutson@eclypsium.com,
        hughsient@gmail.com, alex.bazhaniuk@eclypsium.com,
        alison.schofield@intel.com
Subject: Re: [PATCH v6 4/6] x86/e820: Tag e820_entry with crypto capabilities
Message-ID: <202202071351.AEEEA92@keescook>
References: <20220203164328.203629-1-martin.fernandez@eclypsium.com>
 <20220203164328.203629-5-martin.fernandez@eclypsium.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220203164328.203629-5-martin.fernandez@eclypsium.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, Feb 03, 2022 at 01:43:26PM -0300, Martin Fernandez wrote:
> Add a new enum for crypto capabilities.
> 
> Add a new member in e820_entry to hold whether an entry is able to do
> hardware memory encryption or not.
> 
> Add a new function e820__range_set_crypto_capable to mark all the
> entries in a range of addresses as encryptable. This will be called
> when initializing EFI.
> 
> Change e820__update_table to handle merging and overlap problems
> taking into account crypto_capable.
> 
> Signed-off-by: Martin Fernandez <martin.fernandez@eclypsium.com>
> ---
>  arch/x86/include/asm/e820/api.h   |   1 +
>  arch/x86/include/asm/e820/types.h |  12 +++-
>  arch/x86/kernel/e820.c            | 114 ++++++++++++++++++++++++++++--
>  3 files changed, 119 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/x86/include/asm/e820/api.h b/arch/x86/include/asm/e820/api.h
> index e8f58ddd06d9..4b3b01fafdd1 100644
> --- a/arch/x86/include/asm/e820/api.h
> +++ b/arch/x86/include/asm/e820/api.h
> @@ -17,6 +17,7 @@ extern bool e820__mapped_all(u64 start, u64 end, enum e820_type type);
>  extern void e820__range_add   (u64 start, u64 size, enum e820_type type);
>  extern u64  e820__range_update(u64 start, u64 size, enum e820_type old_type, enum e820_type new_type);
>  extern u64  e820__range_remove(u64 start, u64 size, enum e820_type old_type, bool check_type);
> +extern u64  e820__range_set_crypto_capable(u64 start, u64 size);
>  
>  extern void e820__print_table(char *who);
>  extern int  e820__update_table(struct e820_table *table);
> diff --git a/arch/x86/include/asm/e820/types.h b/arch/x86/include/asm/e820/types.h
> index 314f75d886d0..aef03c665f5e 100644
> --- a/arch/x86/include/asm/e820/types.h
> +++ b/arch/x86/include/asm/e820/types.h
> @@ -46,6 +46,11 @@ enum e820_type {
>  	E820_TYPE_RESERVED_KERN	= 128,
>  };
>  
> +enum e820_crypto_capabilities {
> +	E820_NOT_CRYPTO_CAPABLE	= 0,
> +	E820_CRYPTO_CAPABLE	= 1,
> +};

Is this expected to grow beyond a bool?

> +
>  /*
>   * A single E820 map entry, describing a memory range of [addr...addr+size-1],
>   * of 'type' memory type:
> @@ -53,9 +58,10 @@ enum e820_type {
>   * (We pack it because there can be thousands of them on large systems.)
>   */
>  struct e820_entry {
> -	u64			addr;
> -	u64			size;
> -	enum e820_type		type;
> +	u64				addr;
> +	u64				size;
> +	enum e820_type			type;
> +	enum e820_crypto_capabilities	crypto_capable;
>  } __attribute__((packed));

Is there any concern about growing this structure? The "thousands" note
in the comment is likely rare. FWIW, this seems fine to me, but I
thought I'd mention it.

-- 
Kees Cook
