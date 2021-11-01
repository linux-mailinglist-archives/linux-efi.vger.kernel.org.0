Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2D49441FE1
	for <lists+linux-efi@lfdr.de>; Mon,  1 Nov 2021 19:19:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230384AbhKASVo (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 1 Nov 2021 14:21:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230218AbhKASVn (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 1 Nov 2021 14:21:43 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7D5FC061767
        for <linux-efi@vger.kernel.org>; Mon,  1 Nov 2021 11:12:48 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id s186so22556361yba.12
        for <linux-efi@vger.kernel.org>; Mon, 01 Nov 2021 11:12:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=eclypsium.com; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=jUmtW9ieTzJVG0Be8iIwg22XT1UMCaUVyKpqPEAdOwQ=;
        b=XYBoZ3v+Ug3mMbc1RL281QX/xunn6xIv1r2lPDDa/YJ36r+B7BA8SW5wOHRigoxvms
         ZnKW4ijEzBIBal5JqkOYNX4XRapHS6tKC9NOOy1uONnBUH9pFzhfQUmGxx1tRa7UZRbt
         /OauXdcicyncG3gT8JH2a2ZeYjwza4qqvIb10aNt6vAxyIYZj8kw2b5ewje+j9zCpmKi
         rNjhbB3oXgCyRsZ7AS0vekq4WzRkAa1ApwdiTJSexKAp8trVbKVyKimqLzJTO0ObHhEL
         AgqzyaAKxOD0gQ8W2rblVLxckhVkfXGN3jmRbN4XwyxtUsfPPHqLHTkLhLrvoYFFrPfI
         0DJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=jUmtW9ieTzJVG0Be8iIwg22XT1UMCaUVyKpqPEAdOwQ=;
        b=MgiOMTj00tfPa8mRHWwspRWvoWtiSajL++ra8FSFZs+aXf/9MIanqXKiZtNg5NQTLM
         9g88p4hfmnwqB4hW23XlrFIFo3tfKdhzJFg3xMTabNW5B1PuaQWOLSP8eH3aj2uV8CHd
         RMVUdFDO5t9QIOvdWd7nYnHYn4XiVdYkvVWzZmT1pdh9bgF3fA3ogTZMrwJ5xs73SaIX
         VqNB0bcKc9Mseb4UwlbJp7s4Dw2RYLzkLKXs/1zXoR27jLRrJD00c9+QYVEnsc113mRz
         L6ASl6/1gtJjgLqRQPYs6buY26k7StlSJyBPjjQTmwgxaL+qLNBNsrrk9+weKXWDoz2S
         7KSA==
X-Gm-Message-State: AOAM531gtiNGWKXNijh98LhjEHxxE+HVIrIvvovqi7RcaIgaPNY2eoH7
        NRRQ/Bk5EytGP86Z0p7ZR0c31PTt6KDTRV75FbB8vQ==
X-Google-Smtp-Source: ABdhPJxUns079ldeuup7ldVYlFHpZV4zHEJtzawzlazISTz12c6zo1X8UtQfaJLJhyMmJx/+cdSlwM8Ekit/1NTHaMU=
X-Received: by 2002:a05:6902:120e:: with SMTP id s14mr38572200ybu.161.1635790367873;
 Mon, 01 Nov 2021 11:12:47 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a81:1f09:0:0:0:0:0 with HTTP; Mon, 1 Nov 2021 11:12:47 -0700 (PDT)
In-Reply-To: <b2de42c1-e973-0f4a-635f-8e8bbaebbfa5@intel.com>
References: <20211027195511.207552-1-martin.fernandez@eclypsium.com>
 <8a8e0743-e54d-ec96-da4e-1d101b550274@intel.com> <CAKgze5Z3fT9F0S-mogfP6is9sL3=0imtCbfy6ZYrd3zgaBUqRg@mail.gmail.com>
 <YXq50yzJQqrJk13v@zn.tnic> <CAD2FfiFS++2-Sn5nCft8Eb-R41MM6abCjXyDn8bOVY-_miCpRA@mail.gmail.com>
 <YXrRN+pDr4Uv5p0t@zn.tnic> <CAKgze5av=duAc+inw6XnroT1WxHoP6pA2=Bb2tjK45yO6aDfOg@mail.gmail.com>
 <b2de42c1-e973-0f4a-635f-8e8bbaebbfa5@intel.com>
From:   Martin Fernandez <martin.fernandez@eclypsium.com>
Date:   Mon, 1 Nov 2021 15:12:47 -0300
Message-ID: <CAKgze5binkSSA7p1=R98NSvqQOhQ_J2+0xiSZkboXzw71ceaPg@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] [RFC] x86: Export information about hardware
 memory encryption to sysfs
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Borislav Petkov <bp@alien8.de>,
        Richard Hughes <hughsient@gmail.com>,
        linux-efi@vger.kernel.org,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, X86 ML <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, ardb@kernel.org,
        dvhart@infradead.org, andy@infradead.org,
        Greg KH <gregkh@linuxfoundation.org>, rafael@kernel.org,
        Daniel Gutson <daniel.gutson@eclypsium.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 10/29/21, Dave Hansen <dave.hansen@intel.com> wrote:
> But, I don't think what you've proposed here fits very well there.  The
> ->cpu_local thing looks totally broken.  It's entirely unclear what
> users are supposed to do when the crypto_capable file is not present.
>

Yes, I apologize, it was a misunderstanding between myself and the
team that reviewing the patch before it was sent. The idea behind that
code was to do another thing that we decided to drop. The final
version should have this file for every node in the system.
