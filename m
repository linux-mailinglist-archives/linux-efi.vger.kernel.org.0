Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8F4058941E
	for <lists+linux-efi@lfdr.de>; Wed,  3 Aug 2022 23:43:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237474AbiHCVnu (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 3 Aug 2022 17:43:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232909AbiHCVnt (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 3 Aug 2022 17:43:49 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 415564D83C
        for <linux-efi@vger.kernel.org>; Wed,  3 Aug 2022 14:43:48 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id kb8so19127167ejc.4
        for <linux-efi@vger.kernel.org>; Wed, 03 Aug 2022 14:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=Pct1xZs6hLqNqULkodh51wmxrFs4qJWhdL2uliqX9z8=;
        b=ThtDUjlh3nYCBMHVTfoPueCU0P4iFdtHwtn7kXouWwZDyQiPIlaMNrNpKzEua+wq+K
         qqB7+om5aIPVJnU4yPWlH/bP3JVlemq+ae0G3CJfqj7hxn4Bcubxx9CdPpLSrcvNMK84
         TecfODjxPsDwM0kZAsLKD3nyf8VmnjAfdEFMU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=Pct1xZs6hLqNqULkodh51wmxrFs4qJWhdL2uliqX9z8=;
        b=xB5F3frGJAoxFFFJhIha9uwbxZD3GMr9E/3HFzO0fLp5QtTc0lgzZiSNPrzoIip41Y
         6Azpa0ylcNqGpFH/FzkvRtfMIsJogOWfoi+cXjfvhAw0oSpB51+28pFjTZv4+62j8Dx4
         +P5RRhbb1jC/Ze+UBhcTDTCJyE09eAeNNeh6QNKovS1FmHDmMPCqWjs1dY5R9a8SUuF2
         eJW5A2+TrkFXir8LIIH75n3gj/3SA9ieDlC2dUnJUUTD5AcJrqa8gpAwn69jhrviqMDz
         fBO9Izm78FPV2PIdnBq0FQz4YzgwK2vwI0jP6Te8V/wza/rtQkesxiNslazLHUyTWTTW
         CAlA==
X-Gm-Message-State: AJIora8vlEF7uw9TvKfBXZ3wYQ9YKrRB1ywUgTUoJFl9/RiQz1x3jd56
        oc1FiYdvV5cLbj9rYOx1PkRGroKUVYjlZOWv
X-Google-Smtp-Source: AGRyM1t7zUfJbJ4HVfFFF4Rjbjo0ViNChuANd/2RuiseFY2NF0rgnVE5lNGW7l4bfxl6W5knssf5fQ==
X-Received: by 2002:a17:907:6d26:b0:72b:3a72:a117 with SMTP id sa38-20020a1709076d2600b0072b3a72a117mr21521156ejc.280.1659563026416;
        Wed, 03 Aug 2022 14:43:46 -0700 (PDT)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com. [209.85.128.47])
        by smtp.gmail.com with ESMTPSA id l5-20020aa7d945000000b0043acddee068sm10107369eds.83.2022.08.03.14.43.45
        for <linux-efi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Aug 2022 14:43:45 -0700 (PDT)
Received: by mail-wm1-f47.google.com with SMTP id c187-20020a1c35c4000000b003a30d88fe8eso1530415wma.2
        for <linux-efi@vger.kernel.org>; Wed, 03 Aug 2022 14:43:45 -0700 (PDT)
X-Received: by 2002:a05:600c:4ed0:b0:3a3:3ef3:c8d1 with SMTP id
 g16-20020a05600c4ed000b003a33ef3c8d1mr4049446wmq.154.1659563025430; Wed, 03
 Aug 2022 14:43:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220801134117.1605678-1-ardb@kernel.org> <20220801134117.1605678-3-ardb@kernel.org>
In-Reply-To: <20220801134117.1605678-3-ardb@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 3 Aug 2022 14:43:29 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgHYky=hYU6TQCyW4e1JvqnFuTYm9qHZ5QCE5G6kU0F_w@mail.gmail.com>
Message-ID: <CAHk-=wgHYky=hYU6TQCyW4e1JvqnFuTYm9qHZ5QCE5G6kU0F_w@mail.gmail.com>
Subject: Re: [GIT PULL 2/2] EFI removal of efivars sysfs driver
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, keescook@chromium.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, Aug 1, 2022 at 6:41 AM Ard Biesheuvel <ardb@kernel.org> wrote:
>
> EFI efivars sysfs interface removal

I've pulled this, but let's see if somebody screams. We may have to
reinstate it if it's still used.

            Linus
