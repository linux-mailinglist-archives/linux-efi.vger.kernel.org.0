Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D89B47A1D79
	for <lists+linux-efi@lfdr.de>; Fri, 15 Sep 2023 13:31:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234345AbjIOLbM (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 15 Sep 2023 07:31:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234243AbjIOLbL (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 15 Sep 2023 07:31:11 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7F431AD;
        Fri, 15 Sep 2023 04:31:02 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-31dcf18f9e2so1884400f8f.0;
        Fri, 15 Sep 2023 04:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694777461; x=1695382261; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4LR91jDbhT82zr0n9jJHX5VigPs/ZpXk32vV8Q1Vz3c=;
        b=ZMO2EUbvcw00Il4aJiRiRfRhXfQvLre2PqjA/TM9yXGcXZgMH2S4m9xm51O0aVklPZ
         InBTH9e1crIPMeqg6FMKzZn4mkkzs3GiULbxr8YbLIr+Yja3AdMh8tpatJqQNzaoM62V
         2d2W/5RymeYNkvDT9+BH2NJXTdUgANdeCm36nd0AV5gAN45VgYK+YNVyfLVhs9W3aWfq
         OpmKoVl3P06ZgCQRyT7T1BdGfTbiK27np6t4c5oDXs3AlPwXsMb48AtptRd8RKhKid8Y
         zDPItu784Kqf3GRQaoAm7dX1LL4O7jiU8oAo5gj2WWeh8D2qvvwybWG5knyQu66+4ugx
         kH4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694777461; x=1695382261;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4LR91jDbhT82zr0n9jJHX5VigPs/ZpXk32vV8Q1Vz3c=;
        b=gYmJlOFUQ2SvfvynmOn3z4WcpotX16oIS0Czo976PX2rKE4ZkI0EEO2ORyhjIJ1yWL
         IyX91kMHmj/rVmtkGN5XFp0vBsHffJnDgloiDd6cXHNS09BcTKwowqySiz+hiqAAsdUR
         znEEHcsnKVGR9Hu6VU+49UR0LguxbvWNDFzxyNt+bCyq7Kc4ghZPSBzZw+LhRwFTRUNC
         +VsHkB5JxZNdGWVk3S3ylUUljpam995D1olFzXV8ZkjZsRpKiNGGDHoGNBcGwFYYUbd2
         +jnpvfljNN7Z3O3/b9xCTC2LpIEGlF/I2Bb4n0+7yqZsU+X4+L0RIGpJHUlZ0P6Uf7Cy
         wsKw==
X-Gm-Message-State: AOJu0YwoYQjS68Lbvq2lwBCbimyMnZPz8glqfCsemOvNMnrmRUVhKYtE
        8JQT4H9v9mUq/MSMj7D83Uo=
X-Google-Smtp-Source: AGHT+IFXqF9kII3kAUmZb4zO/yHMODlRmBXr1aN2q4n6+SsUxwBxztG+fhH2Aad/2ESymAgGJlRvxA==
X-Received: by 2002:adf:e40c:0:b0:31f:b36b:6d45 with SMTP id g12-20020adfe40c000000b0031fb36b6d45mr1065646wrm.52.1694777460937;
        Fri, 15 Sep 2023 04:31:00 -0700 (PDT)
Received: from gmail.com (1F2EF265.nat.pool.telekom.hu. [31.46.242.101])
        by smtp.gmail.com with ESMTPSA id a4-20020adffb84000000b0031c5e9c2ed7sm4172487wrr.92.2023.09.15.04.30.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 04:31:00 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Fri, 15 Sep 2023 13:30:58 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Ard Biesheuvel <ardb@google.com>
Cc:     linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ard Biesheuvel <ardb@kernel.org>,
        Evgeniy Baskov <baskov@ispras.ru>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Jones <pjones@redhat.com>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v2 00/15] x86/boot: Rework PE header generation
Message-ID: <ZQRAckHVxQZRNEGA@gmail.com>
References: <20230912090051.4014114-17-ardb@google.com>
 <ZQQiUxh5vmeZnp7s@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZQQiUxh5vmeZnp7s@gmail.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org


* Ingo Molnar <mingo@kernel.org> wrote:

> > Ard Biesheuvel (15):
> >   x86/efi: Drop EFI stub .bss from .data section
> >   x86/efi: Disregard setup header of loaded image
> >   x86/efi: Drop alignment flags from PE section headers
> >   x86/boot: Remove the 'bugger off' message
> >   x86/boot: Omit compression buffer from PE/COFF image memory footprint
> >   x86/boot: Drop redundant code setting the root device
> >   x86/boot: Grab kernel_info offset from zoffset header directly
> >   x86/boot: Drop references to startup_64
> 
> I've applied these first 8 patches to tip:x86/boot with minor edits.
> (Please preserve existing comment capitalization conventions ...)
> 
> >   x86/boot: Set EFI handover offset directly in header asm
> >   x86/boot: Define setup size in linker script
> >   x86/boot: Derive file size from _edata symbol
> >   x86/boot: Construct PE/COFF .text section from assembler
> >   x86/boot: Drop PE/COFF .reloc section
> >   x86/boot: Split off PE/COFF .data section
> >   x86/boot: Increase section and file alignment to 4k/512
> 
> The rest conflicted with recent upstream changes, and I suppose it's
> prudent to test these changes bit by bit anyway.

So, the first 8 patches broke the x86-64-defconfig-ish Qemu bzImage bootup,
due to the 8th patch:

  988b52b207a9fe74c3699bda8c2256714926b94b is the first bad commit
  commit 988b52b207a9fe74c3699bda8c2256714926b94b
  Author: Ard Biesheuvel <ardb@kernel.org>
  Date:   Tue Sep 12 09:01:01 2023 +0000

      x86/boot: Define setup size in linker script

I've removed it for now - but this side effect was not expected.

Thanks,

	Ingo
