Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4644859C969
	for <lists+linux-efi@lfdr.de>; Mon, 22 Aug 2022 21:59:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234845AbiHVT6c (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 22 Aug 2022 15:58:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238192AbiHVT6Q (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 22 Aug 2022 15:58:16 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41CEE4DB22
        for <linux-efi@vger.kernel.org>; Mon, 22 Aug 2022 12:58:00 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id 67so3186803pfv.2
        for <linux-efi@vger.kernel.org>; Mon, 22 Aug 2022 12:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=gL8S3Ikjz9wTXDGrrwW0svnB7hiz+ZH+XPDtqzGZVjw=;
        b=NtD/Z15jlaZ6GhAycO24WkNHU1y8pF+4+bM6NIIAZ/8Vpdcs2Zo1nzlJRJKN5G7Ihg
         PoePmr0KNOPdQevDM3yWeA5LUnTEPiOH6nEFb+utQWTC9P4gol1OipS+szGRn0r9ioyH
         J+CBr4fOoCGpxwwHgJvaxKkijKIbgieyQBfAA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=gL8S3Ikjz9wTXDGrrwW0svnB7hiz+ZH+XPDtqzGZVjw=;
        b=Y2CAjdnGaJ8uRyRWZJ4RUC+pkGG/MZt4a8yaa1ts0T+deSG2oQH2iNnN9onLfKOVwF
         dLbt/AW6awCJZoAX7Ul+KqHz6+LcVLUpiw9hnZo3I56Dft02gjv+mYME4RwKEk7GPjDX
         4vYuQh0FvP56YOJwOjGMWlso4Z9khW9z/0y1t219OIW7v2uEiIIqc7ziTP9IPnIHuXji
         L2tXICn5MP3DEwsEE026AmmwEec2CARKpk5Ao5ICTixGhMEIdS5daLdq/5pfsmJt5sBF
         HkRGGCFXAXwO2dFdZ7Y3PXLyHv6pKfeYZ9tA1X/Y5G9QNVN+k7g/J/Oim4xoZGlHbmZn
         GnlQ==
X-Gm-Message-State: ACgBeo3zTUj/Fj51wP8oqHbOlN8LW3Lx+OpyuYFwiJJYM0RrxcdxhP9u
        lwtYDHvS9ArmLZhC0YVV1AxGW0DHhu6ijw==
X-Google-Smtp-Source: AA6agR5Nz5Sudd15RhNGUvaat4IJ2kDhg2BaoZngcdgG/R4nTBO4LvawBHPdJho/EEhPV0puq1GO2A==
X-Received: by 2002:a63:cf05:0:b0:429:bf9c:1f71 with SMTP id j5-20020a63cf05000000b00429bf9c1f71mr17768734pgg.178.1661198279386;
        Mon, 22 Aug 2022 12:57:59 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id y11-20020a17090a784b00b001f021cdd73dsm10380265pjl.10.2022.08.22.12.57.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Aug 2022 12:57:58 -0700 (PDT)
Date:   Mon, 22 Aug 2022 12:57:57 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org,
        Daniel Marth <daniel.marth@inso.tuwien.ac.at>
Subject: Re: [PATCH] efi: libstub: Disable struct randomization
Message-ID: <202208221257.06B78617C5@keescook>
References: <20220822172953.3918414-1-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220822172953.3918414-1-ardb@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, Aug 22, 2022 at 07:29:53PM +0200, Ard Biesheuvel wrote:
> The EFI stub is a wrapper around the core kernel that makes it look like
> a EFI compatible PE/COFF application to the EFI firmware. EFI
> applications run on top of the EFI runtime, which is heavily based on
> so-called protocols, which are struct types consisting [mostly] of
> function pointer members that are instantiated and recorded in a
> protocol database.
> 
> These structs look like the ideal randomization candidates to the
> randstruct plugin (as they only carry function pointers), but of course,
> these protocols are contracts between the firmware that exposes them,
> and the EFI applications (including our stubbed kernel) that invoke
> them. This means that struct randomization for EFI protocols is not a
> great idea, and given that the stub shares very little data with the
> core kernel that is represented as a randomizable struct, we're better
> off just disabling it completely here.
> 
> Reported-by: Daniel Marth <daniel.marth@inso.tuwien.ac.at>
> Tested-by: Daniel Marth <daniel.marth@inso.tuwien.ac.at>
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>

Acked-by: Kees Cook <keescook@chromium.org>

-Kees

-- 
Kees Cook
