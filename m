Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24FCD553D54
	for <lists+linux-efi@lfdr.de>; Tue, 21 Jun 2022 23:18:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354518AbiFUVOY (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 21 Jun 2022 17:14:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355898AbiFUVNZ (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 21 Jun 2022 17:13:25 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9F4C33352
        for <linux-efi@vger.kernel.org>; Tue, 21 Jun 2022 14:00:14 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id s185so8455194pgs.3
        for <linux-efi@vger.kernel.org>; Tue, 21 Jun 2022 14:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=hFqBmB+kt0rtaIPaQ9KZ5LuoFwIj2x82PzqkrWEtyKU=;
        b=TNa3pSTndKVSyB2tGrJa9c+jY2RecssGJr47JZaCbPMcVuC5JrbHKKt4/sTBfy52GX
         ZoLBBfUJo0HpLu6z4QDbh3mMi+ILoX65eJSlThihVfGNx2lz7CcWiy6CJwW5sKxAk5V0
         kHbpvT1+WcXU6+Jgx5jvCPwMXIALyfuHX8Nc8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hFqBmB+kt0rtaIPaQ9KZ5LuoFwIj2x82PzqkrWEtyKU=;
        b=McrUN2o/8wjLCr5mFic3yTUp4Ik0fYnyhq0gYwxxfVQfkpEdX+x4srhJ3iY/P9JuUH
         HgMbAgj+5wzmBN3VZgeQK056WPGTzZIWWgsJV5LwbU6sYGd/yyqsfITQJupyz1A7SxFX
         PmuVv7c1A7Za2tF31DRiqpvdz+Hl2g9Tz6fhAFaEkChNUyq7xTQaDpxWTM9/5AMfm2Nt
         A88bfgLzzD+ZP2xUNPIANEaepAZNEnm+WFPv6hR0GOugkGnOxJYUOZwO/sRakmB9NUTr
         ULuLTE6knQ6FsRWhfPByB5Kkwau+VcNoaXv3hJdoBFUIPFDlSs7jdJTHSEISmZ/PUXGd
         OipQ==
X-Gm-Message-State: AJIora/aS+/4ZT8kLNzTILGYmWn+qCl+JVzk2M0XLxEyUILhIWn643ub
        R8XrhGH6SiXAykHUaFHxCKjmlA==
X-Google-Smtp-Source: AGRyM1vS1WHRdTIT9IYRs+xx+wXkAMDh2br3ATVm9QvwiP+IUHXwkOKN9l90zBOq2MpUpC4k5ZJgrQ==
X-Received: by 2002:a63:1e0e:0:b0:3f6:4dce:918b with SMTP id e14-20020a631e0e000000b003f64dce918bmr28558117pge.53.1655845214448;
        Tue, 21 Jun 2022 14:00:14 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id x139-20020a627c91000000b0050dc7628196sm6251408pfc.112.2022.06.21.14.00.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jun 2022 14:00:14 -0700 (PDT)
Date:   Tue, 21 Jun 2022 14:00:13 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Peter Jones <pjones@redhat.com>,
        Tony Luck <tony.luck@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCH v2 4/9] efi: pstore: Omit efivars caching EFI varstore
 access layer
Message-ID: <202206211357.C66CD742E5@keescook>
References: <20220621153623.3786960-1-ardb@kernel.org>
 <20220621153623.3786960-5-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220621153623.3786960-5-ardb@kernel.org>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, Jun 21, 2022 at 05:36:18PM +0200, Ard Biesheuvel wrote:
> Avoid the efivars layer and simply call the newly introduced EFI
> varstore helpers instead. This simplifies the code substantially, and
> also allows us to remove some hacks in the shared efivars layer that
> were added for efi-pstore specifically.
> 
> Since we don't store the name of the associated EFI variable into each
> pstore record when enumerating them, we have to guess the variable name
> it was constructed from at deletion time, since we no longer keep a
> shadow copy of the variable store. To make this a bit more exact, store
> the CRC-32 of the ASCII name into the pstore record's ECC region so we
> can use it later to make an educated guess regarding the name of the EFI
> variable.

I wonder if pstore_record should have a "private" field for backends to
use? That seems like it solve the need for overloading the ecc field,
and allow for arbitrarily more information to be stored (i.e. store full
efi var name instead of an easily-colliding crc32?)

-- 
Kees Cook
