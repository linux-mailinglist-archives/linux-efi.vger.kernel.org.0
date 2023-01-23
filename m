Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0F606786E6
	for <lists+linux-efi@lfdr.de>; Mon, 23 Jan 2023 20:55:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231925AbjAWTzA (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 23 Jan 2023 14:55:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231468AbjAWTzA (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 23 Jan 2023 14:55:00 -0500
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D10E26591
        for <linux-efi@vger.kernel.org>; Mon, 23 Jan 2023 11:54:59 -0800 (PST)
Received: by mail-qt1-x82d.google.com with SMTP id o5so10906779qtr.11
        for <linux-efi@vger.kernel.org>; Mon, 23 Jan 2023 11:54:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ghtTK62dcFpd/l1wunnizGLFduGCG/CbyOlXuyRg3Xc=;
        b=ao3OpElKkNw4KWk0/8snH0/EY7dDMPeq7DCsI+/AP1/yiD7ssoawy2xL2fEo9TeZsh
         vJM5+ej/hErHf7nWMT+hW7HzOo3q3pyHrJMJvlcL4No2gHGFjLBTbO/HFky4tZFftZrJ
         XGl0BWmEYKnOT59I5eel2Igzc2PhOGWCxS5RQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ghtTK62dcFpd/l1wunnizGLFduGCG/CbyOlXuyRg3Xc=;
        b=LFqu06JfrEBSW93/7Jd+i5iHGlgA/o2No5iUkhn8m9wVN0mY6fHAlZF73E9FwSuyDI
         bACcqERyu1BY+0aRn49jJpKAHM7/eihmSlwt778uw3n4rq6Efy+u3iAXLV3B2ecnVdai
         or1jLvN7Lyb27VgHD51T4twauH3ejUTncuqYPpkcz1HHYaYrYxEwjU95sRYbpSZCwmZW
         elY+u5BC2Q2RPpPwP8oy6kq2a7VHVERFBRYbtBeMHswoEjNm39GE1blOwV1vUeIqxhrs
         MUQeDRFEEmEvJTxPF4t0zm2S9lqyMwMK06oWDKds7fBnh5dezjpV+YowqsEgApeGPfiW
         jfWg==
X-Gm-Message-State: AFqh2kqJVnIDHlQch1GoyhW15SDP+IqF2IfjFcGUyQOKcB0OWbaZQtoK
        IEx1slwVZKg0eRUOq3hDx6W1TvqvFiOwbvDA
X-Google-Smtp-Source: AMrXdXvIKU7/erP2g++fR/GKb+u6gqcdXVPRe6idQuxGtz14WdG9G4cWkeXhai4A6Tdkn+CmI9fWUg==
X-Received: by 2002:a05:622a:5c99:b0:3a8:1295:f96a with SMTP id ge25-20020a05622a5c9900b003a81295f96amr37663387qtb.7.1674503698339;
        Mon, 23 Jan 2023 11:54:58 -0800 (PST)
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com. [209.85.222.179])
        by smtp.gmail.com with ESMTPSA id r13-20020ac87eed000000b003b6302f2580sm12411169qtc.22.2023.01.23.11.54.57
        for <linux-efi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Jan 2023 11:54:57 -0800 (PST)
Received: by mail-qk1-f179.google.com with SMTP id z9so6981870qkl.13
        for <linux-efi@vger.kernel.org>; Mon, 23 Jan 2023 11:54:57 -0800 (PST)
X-Received: by 2002:ae9:efd8:0:b0:706:e593:2598 with SMTP id
 d207-20020ae9efd8000000b00706e5932598mr713853qkg.216.1674503697416; Mon, 23
 Jan 2023 11:54:57 -0800 (PST)
MIME-Version: 1.0
References: <20230123164518.557152-1-ardb@kernel.org>
In-Reply-To: <20230123164518.557152-1-ardb@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 23 Jan 2023 11:54:41 -0800
X-Gmail-Original-Message-ID: <CAHk-=wicrdH2+ftvEtNHnNZvBO1bfMVRH10s59ZrWpAnwckJxQ@mail.gmail.com>
Message-ID: <CAHk-=wicrdH2+ftvEtNHnNZvBO1bfMVRH10s59ZrWpAnwckJxQ@mail.gmail.com>
Subject: Re: [GIT PULL] EFI fixes for v6.2 #2
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org
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

On Mon, Jan 23, 2023 at 8:45 AM Ard Biesheuvel <ardb@kernel.org> wrote:
>
> - remove Matt Garrett's MAINTAINERS entry for efivarfs

I was all "who?", and had to look, and then went "Oh, you mean _Matthew_".

I didn't think he's ever gone by Matt, at least in kernel circles -
either in email or in person. At least not that I can remember.

So I edited it. Apologies to Matthew if he has now started going by Matt.

               Linus
