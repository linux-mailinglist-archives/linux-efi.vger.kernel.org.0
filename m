Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D40D65B0846
	for <lists+linux-efi@lfdr.de>; Wed,  7 Sep 2022 17:17:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229634AbiIGPRI (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 7 Sep 2022 11:17:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbiIGPRH (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 7 Sep 2022 11:17:07 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE4556E2E7
        for <linux-efi@vger.kernel.org>; Wed,  7 Sep 2022 08:17:05 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id o126so5962922pfb.6
        for <linux-efi@vger.kernel.org>; Wed, 07 Sep 2022 08:17:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=rJyHNtbAAmc/M9+KIOe4h2Tqp+TBMSNYMcKla0oYXww=;
        b=Ab5uJKiYNDXmJ4FnUMH6jqRjSbxQAlFI2/cgoRalg76ddAtouz9di30gqR3OOyKDJn
         hKL6E+E32byhFUyyIT2iPsXiS2VT4tixxDUfKgwsj3AdYI78aFNSLwgnk0yw2vItPN9F
         ikAnxlXmWk+CLs1jddkGPI+zx0CCFm2RqgzpSSU774XlS9cI9kaHBphyO8JvxMl3c5F+
         PUSMGBp6/ujO32TL2Ol8geI6woXVpfGKSC3gbDU9AcJQklU9IAdodlA1cN1NI39Vyvyu
         8Q/5+0Pkb9s5grliDG+sT+S/BzA6JtJj2GyPgIHxBtNTduIXRFYanrFZ5dzaromqy1sm
         74wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=rJyHNtbAAmc/M9+KIOe4h2Tqp+TBMSNYMcKla0oYXww=;
        b=0WCHlVnLHZiWsP3fYIGsQwMNlRG/a4zxcZnFuLt3fRXkalhVZ/WWjrTVtm1b4sVdON
         Cf5WSEMOz6fAez+Hv/V/OuJjbMEcX2O9bqNcI0T9M8bYbP8M6lWMj4waq0nqV2s5I0sI
         d26M/J0zN9AqA554saey61bKUvq+H+woL4P+lm9F/5yIHfaVbyoRPI8oegahRuFREkub
         Lb+t2+WmnOU5jEA22ZZTZyJEbHe3KWj0vWsaoB7hGFHVPecV3x8vIny/wR49/Yrei6Sf
         ninZr+qYwoF54pQ5TSgkLRP67fgF2EsVrKT6HE3ifA5w4yGSGQg8Rf4lK1qprlQTb35I
         8+Wg==
X-Gm-Message-State: ACgBeo3FnY8TEL80ef7cDM13EJJ19fthMgSe49FYatSTt7EzfYyC77Fx
        rz+E3Q6QPbQc6YhskqldMeE=
X-Google-Smtp-Source: AA6agR7XqfE1ryignwsTAxQRw21GXY/Vl4ZnA2+SdipIuSYNhZJH9fgl+hG+PBNAHWIMonERQK8oXw==
X-Received: by 2002:a05:6a00:ad1:b0:530:2cb7:84e2 with SMTP id c17-20020a056a000ad100b005302cb784e2mr4288468pfl.18.1662563825248;
        Wed, 07 Sep 2022 08:17:05 -0700 (PDT)
Received: from ubuntu ([175.124.254.119])
        by smtp.gmail.com with ESMTPSA id d4-20020a17090abf8400b001ef8ab65052sm11082447pjs.11.2022.09.07.08.17.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Sep 2022 08:17:04 -0700 (PDT)
Date:   Wed, 7 Sep 2022 08:17:01 -0700
From:   Hyunwoo Kim <imv4bel@gmail.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, imv4bel@gmail.com
Subject: Re: [PATCH] efi/capsule-loader: Fix use-after-free in
 efi_capsule_write
Message-ID: <20220907151701.GA127727@ubuntu>
References: <20220626103248.GA57385@ubuntu>
 <CAMj1kXHo91v8u_RcXfu4r=x5eh-tShBu4gSDZXBRveOC275Fnw@mail.gmail.com>
 <20220907102920.GA88602@ubuntu>
 <CAMj1kXHKBkP8JHUSyzEELovvSzUpfO1j2nA+eUbP-smLWjKPog@mail.gmail.com>
 <20220907145426.GA127455@ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220907145426.GA127455@ubuntu>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Sep 07, 2022 at 07:54:26AM -0700, Hyunwoo Kim wrote:
> efi_capsule_flush() seems to exist for the purpose of canceling uploads in the middle.
> 
> If buffer release is moved to .release, will there be any compatibility issues?

The way to submit capsules is to submit by calling write() multiple times by the user, 
rather than in a structure that processes the copy operation at once inside efi_capsule_write().
In other words, if you just call close() when you want to cancel upload, 
.release is automatically called after write() is finished, and upload is stopped.
So there is no need for .flush to exist.

So I think it would be ok to move the buffer free part to .release.

I'll submit you a v4 patch that moves the buffre free part to .release.
