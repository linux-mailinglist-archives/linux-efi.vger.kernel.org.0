Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 14A7C95E74
	for <lists+linux-efi@lfdr.de>; Tue, 20 Aug 2019 14:27:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729896AbfHTM1g (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 20 Aug 2019 08:27:36 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54190 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729525AbfHTM1g (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 20 Aug 2019 08:27:36 -0400
Received: by mail-wm1-f68.google.com with SMTP id 10so2452671wmp.3
        for <linux-efi@vger.kernel.org>; Tue, 20 Aug 2019 05:27:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Fc9kgafPA2gUOPbQU1W3ajBr+1WrHB60fZSaC4Wi+Sg=;
        b=NlUKtmn9iGLGYzl/EGuxT5/QFDiWGwqT+SyseUqGQ8qv1eVKlAZutSafi0AbgwxVya
         6dqyEnKyli5cUAbyM+8YbVFbhOu1g4+mjswnShlQVVmHQ74gvUa5wUgoJq+rcOUOCvp2
         /U6ehhgch2rOD/YINXpXSo6Gl1MDVdnWaODFMbh+HsJrCi//AnlfQ1VitYLR3Vcqnujk
         4euj7syu8yOnXtSIDBrNYa44gL/mcHfIA5JvOAiTKPyRh/RjIEdyPBCtYMxXb3hmso6F
         dm3NpN8gr1s4exi5lvCCKYMLdjzcAo+jvdxcx8iU45Rf227pWO1z6xbvBMFCIZ1djaO5
         mSWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Fc9kgafPA2gUOPbQU1W3ajBr+1WrHB60fZSaC4Wi+Sg=;
        b=lHlfX/Gu9hRERAdLkbMHBnneGlYV5muZwQoQOXiavi+dnokDlM0o6iX5brDBsJVTB4
         VRPP55lWCfFYeXmQ3909u0zN6JZfe3nbpvOvZARdoDQ1NWdcg+JeA+FUFSZqZ6rZzf7B
         myzOsnJKhlH74VRqhnaJgLLAWD9JqcKoVwuXE2IZOcwdHjUgfcbJfBK1KyRULLCuGWXw
         QMp+WgDchSGbYlJb3eO3mHWMc5X4DjEI2WVm4uAlm679Zpvera6ahZxaEp36pf94vnRs
         nXlwxb4soxeWIaQ418vnlzA6yWAdK+7mCq3/WEJJjNoPOz7cXlahepBQJ3ONYDBdN9rr
         5M2g==
X-Gm-Message-State: APjAAAWt0ABJXIU1JAci7GzG50SJF0osNFVhrNeRxYqhqRXH9JNsjXvJ
        eLXx3HcJQMO5okEQK5/SC79J02cYAL+S+Y91Axm/Pw==
X-Google-Smtp-Source: APXvYqzZ8/F9f0NciEUL0j31UKBINg5KnpUK5KcUIV+VxonHUHvdyeOCmoqDvaTzkRhT6wtLRbUezdw96auKzQMDFR0=
X-Received: by 2002:a05:600c:231a:: with SMTP id 26mr17871560wmo.136.1566304054078;
 Tue, 20 Aug 2019 05:27:34 -0700 (PDT)
MIME-Version: 1.0
References: <20190802053744.5519-1-clin@suse.com> <CAKv+Gu-yaNYsLQOOcr8srW91-nt-w0e+RBqxXGOagiGGT69n1Q@mail.gmail.com>
 <20190820115409.GO13294@shell.armlinux.org.uk>
In-Reply-To: <20190820115409.GO13294@shell.armlinux.org.uk>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Tue, 20 Aug 2019 15:27:23 +0300
Message-ID: <CAKv+Gu8DBA8SoJ49dMeYjXHchGZpAiLgxLEQF7jQGtdQ6camdw@mail.gmail.com>
Subject: Re: [PATCH] efi/arm: fix allocation failure when reserving the kernel base
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     Chester Lin <clin@suse.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "rppt@linux.ibm.com" <rppt@linux.ibm.com>,
        "ren_guo@c-sky.com" <ren_guo@c-sky.com>,
        Juergen Gross <JGross@suse.com>,
        "geert@linux-m68k.org" <geert@linux-m68k.org>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        "guillaume.gardet@arm.com" <guillaume.gardet@arm.com>,
        Joey Lee <JLee@suse.com>, Gary Lin <GLin@suse.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, 20 Aug 2019 at 14:54, Russell King - ARM Linux admin
<linux@armlinux.org.uk> wrote:
>
> On Sun, Aug 04, 2019 at 10:57:00AM +0300, Ard Biesheuvel wrote:
> > (The first TEXT_OFFSET bytes are no longer used in practice, which is
> > why putting a reserved region of 4 KB bytes works at the moment, but
> > this is fragile).
>
> That is not correct for 32-bit ARM.  The swapper page table is still
> located 16kiB below the kernel.
>

Right. So that means we can only permit reserved regions in the first
(TEXT_OFFSET - 16 kiB) bytes starting at the first 128 MiB aligned
address covered by system RAM, if we want to ensure that the
decompressor or the early kernel don't trample on it. (or TEXT_OFFSET
- 20 kiB for LPAE kernels)
