Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 804C7442174
	for <lists+linux-efi@lfdr.de>; Mon,  1 Nov 2021 21:11:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231145AbhKAUNa (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 1 Nov 2021 16:13:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbhKAUN0 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 1 Nov 2021 16:13:26 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31AE5C061764
        for <linux-efi@vger.kernel.org>; Mon,  1 Nov 2021 13:10:52 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id s186so23322557yba.12
        for <linux-efi@vger.kernel.org>; Mon, 01 Nov 2021 13:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=eclypsium.com; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ZUgxn0lmh9dNAC/c7eLSOzWzcjlgZ0KBJZDm+rIaPh4=;
        b=YmJGbHyYO8FjlHaWXdqQX2ep6ZWcZgf80vvHkiIaNcD22F5NdLLVVDCNr1fvMk2xub
         LhleTXjFhoen4O5pB9quoVWb+3A/RrmauG0733odq0WJxJxUx651forzxOnYt9WfOBY5
         Prn8FSgNUaW06qQWbL5P3YsGm+sMoq0JKuHt6nwiNyI09b/YXdmT4nMQrJjJhFREsO5Z
         lNRWifj4T/RmiFBiQOdc3oTZhwulo838MtWCikPFfA4HraMLGEzqVqixJN6kmja9W5M7
         1dKSMPjR2V1atiumdOzqsz51Ygj/M0QFrdCUfQX8xfdSPS94pAdYlJlrrxDV/t1aFlrL
         LutQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ZUgxn0lmh9dNAC/c7eLSOzWzcjlgZ0KBJZDm+rIaPh4=;
        b=td95EtrdpQFrYeM00j04LFWZ6EBAs50Yv2Acfd8RM/ZpobUmRirHHTGj/Onrsp35dZ
         QD37r3Ft7OQR2HRd8chM3OrGsQyNRDyzG4R+Qw62y3vUgao+9cY8FrJHF39itcPWawwh
         m5c00WAVwRCIbtx6W+mAU2Mk8dBPMNSktqBFW647ONNkoEsee9gJnv4F+MbSSAe3+ZzX
         7Kw5oB0eBBEeMByeehmQchv1jt+mVRmLYwT2G56eX7ku3sl5soyfxUDCkqpc5qpoWKKJ
         6FaJvYPHBafDWbIONKUhlWOoAtnK72PTBpF1aOgKY5VEWR3E8QYSSb5jd4jrFewy8EzF
         Be6A==
X-Gm-Message-State: AOAM53182x3t2bIskqvXA2siVKsjrXpLI/TOfjwLJQiUVJAgafjMCfil
        uxH76zPaiTOv6DAHaO6wZKY46VPLC0Ep/XBlb4LenQ==
X-Google-Smtp-Source: ABdhPJxmRcGVfjTG7RNJkd3yvtG0SUwIlVzcS87rMZlBppb9lOFjIYHC9m9jEXeCc6OPjQoMsiCvGeAPeCuJrpPHoDQ=
X-Received: by 2002:a25:2d1:: with SMTP id 200mr17630104ybc.528.1635797451467;
 Mon, 01 Nov 2021 13:10:51 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a81:1f09:0:0:0:0:0 with HTTP; Mon, 1 Nov 2021 13:10:50 -0700 (PDT)
In-Reply-To: <b2de42c1-e973-0f4a-635f-8e8bbaebbfa5@intel.com>
References: <20211027195511.207552-1-martin.fernandez@eclypsium.com>
 <8a8e0743-e54d-ec96-da4e-1d101b550274@intel.com> <CAKgze5Z3fT9F0S-mogfP6is9sL3=0imtCbfy6ZYrd3zgaBUqRg@mail.gmail.com>
 <YXq50yzJQqrJk13v@zn.tnic> <CAD2FfiFS++2-Sn5nCft8Eb-R41MM6abCjXyDn8bOVY-_miCpRA@mail.gmail.com>
 <YXrRN+pDr4Uv5p0t@zn.tnic> <CAKgze5av=duAc+inw6XnroT1WxHoP6pA2=Bb2tjK45yO6aDfOg@mail.gmail.com>
 <b2de42c1-e973-0f4a-635f-8e8bbaebbfa5@intel.com>
From:   Martin Fernandez <martin.fernandez@eclypsium.com>
Date:   Mon, 1 Nov 2021 17:10:50 -0300
Message-ID: <CAKgze5bRTeqZ0zmbykk24TAPzj6mQ3=xMQXn5k37rNm4bFVKMw@mail.gmail.com>
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
        Daniel Gutson <daniel.gutson@eclypsium.com>,
        alison.schofield@intel.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 10/29/21, Dave Hansen <dave.hansen@intel.com> wrote:
> I don't think this interface makes any sense at all for something off of
> which to base firmware updates.  It's just too noisy.
>
> That said, I *do* think we are going to need something similar to what
> you propose here because folks are going to want to target memory
> allocations to NUMA nodes that have encryption capabilities.

And how do think we should approach this? Putting apart the TME part,
ie, this patch as it is (but showing the file for every node), what do
think it's the next step?
