Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B08A843E76F
	for <lists+linux-efi@lfdr.de>; Thu, 28 Oct 2021 19:39:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230174AbhJ1RmV (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 28 Oct 2021 13:42:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbhJ1RmV (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 28 Oct 2021 13:42:21 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFF8FC061570
        for <linux-efi@vger.kernel.org>; Thu, 28 Oct 2021 10:39:53 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id 131so5706764ybc.7
        for <linux-efi@vger.kernel.org>; Thu, 28 Oct 2021 10:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=eclypsium.com; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=W1f2gS5w9RPHTvCzzmz1e/QkMbgNP6BaJ0hnME4yrHU=;
        b=Bbsl3nE82zSZTrY7uuAQT159b9jVzNYDsSvaYyk72no5eByMgX6lYAbAohN8+5YOak
         y+9ov7zVSowAs8ZIHHSPImiE6FblFy8v/wxI8X3PwalT0tAn+U2F+J1RVljo6E7RA6Jo
         DJ6zkoi4pJeUYmJ5mGh+lk1zZkpLD85ZBFB76ULKzU0xtnjcaRwm08NSdgMCPTjLnmwm
         cbv47iRZCX2BhPfHhjoxFfVSNdv6efvriAdy3e2T+2S+nMx9cI+m+NMgopCwAPxwE9sJ
         yYYWmx1dIlPzPyeTPpm13zhMx3e+D4RDw5splOu29I6F8t+oy1xLoVjuenhY20SFjmaZ
         qjPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=W1f2gS5w9RPHTvCzzmz1e/QkMbgNP6BaJ0hnME4yrHU=;
        b=TnDLnRpL8c3f1MZo8A4RhZORMChpA6yeIA5D71H1LC3fmhTE5XdDExssT2yZhosa2p
         Fj1g4sS+J8MffevaAeFDYeLRRK7vWkW/PRfGOG63FDiPhO7eVbkKfnbJCLWtGDCTpXDb
         50wX9oisZz4fDmqfz0Dw+hK8mNdZKkp0oTK9L8eZo/QYg6oHnDlS6gPjPOHkcrYS8Tkk
         z3jOyRzwl6TeMCN5DKDyWobBi45coXl5v4P+gMPSfhzUx28nGXYMrTcNaiX+oYu/GBxM
         TaR5+MHKi3/CjixnZjp8mYF4jbzAssfJIi+nAPVyJ1lp7G0kx14C+DwdvaM9xAvOroq9
         6hAw==
X-Gm-Message-State: AOAM530jVAzHKD8G5QR3zGih1tAqVFr4N/8FQIUzjiwesd6zvTiWweyv
        i3VfEZVT02hcEXGL3DevK+0QMD7eUZ/02wgGUD1FnQ==
X-Google-Smtp-Source: ABdhPJxIIL0Pn1I1mOw3RslKvcbdv03n4IkVKmZoC6i3aANqW5YJsjL02YTIfDXRUqgBymu3Gb3veiEEckgrT36NziM=
X-Received: by 2002:a25:dd44:: with SMTP id u65mr6011865ybg.278.1635442792889;
 Thu, 28 Oct 2021 10:39:52 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a81:1f09:0:0:0:0:0 with HTTP; Thu, 28 Oct 2021 10:39:52
 -0700 (PDT)
In-Reply-To: <YXrRN+pDr4Uv5p0t@zn.tnic>
References: <20211027195511.207552-1-martin.fernandez@eclypsium.com>
 <8a8e0743-e54d-ec96-da4e-1d101b550274@intel.com> <CAKgze5Z3fT9F0S-mogfP6is9sL3=0imtCbfy6ZYrd3zgaBUqRg@mail.gmail.com>
 <YXq50yzJQqrJk13v@zn.tnic> <CAD2FfiFS++2-Sn5nCft8Eb-R41MM6abCjXyDn8bOVY-_miCpRA@mail.gmail.com>
 <YXrRN+pDr4Uv5p0t@zn.tnic>
From:   Martin Fernandez <martin.fernandez@eclypsium.com>
Date:   Thu, 28 Oct 2021 14:39:52 -0300
Message-ID: <CAKgze5av=duAc+inw6XnroT1WxHoP6pA2=Bb2tjK45yO6aDfOg@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] [RFC] x86: Export information about hardware
 memory encryption to sysfs
To:     Borislav Petkov <bp@alien8.de>
Cc:     Richard Hughes <hughsient@gmail.com>,
        Dave Hansen <dave.hansen@intel.com>, linux-efi@vger.kernel.org,
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

On 10/28/21, Borislav Petkov <bp@alien8.de> wrote:
> Why cannot this be a userspace program, script, tool, whatever?

Because it's not convenient to parse dmesg. And about /proc/cpuinfo,
it tells you about TME, as a feature of the cpu but it doesn't tell
you if it is activated, and even if it is activated you will need to
be sure that you are storing your data in a region flagged with this
new attribute.

Here we discussed about it some time ago:
http://lkml.iu.edu/hypermail/linux/kernel/2006.2/06753.html . That
comment is what triggered this patch.
