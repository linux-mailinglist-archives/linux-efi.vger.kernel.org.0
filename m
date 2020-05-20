Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8A5D1DBC14
	for <lists+linux-efi@lfdr.de>; Wed, 20 May 2020 19:56:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726754AbgETR4l (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 20 May 2020 13:56:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726576AbgETR4k (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 20 May 2020 13:56:40 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7B64C061A0E
        for <linux-efi@vger.kernel.org>; Wed, 20 May 2020 10:56:40 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id s10so1809091pgm.0
        for <linux-efi@vger.kernel.org>; Wed, 20 May 2020 10:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Pty6C2nrLJxasEr51wGRq0lQ2nqP2bOfYIiMHMUP8D4=;
        b=sEj297nZW6hx12Of6Jrt2tzuj8Tydj3iqonbVwfnj8wMbBdLZwyqzlMMBPBF73QUz8
         8usHo5Y5t0YB1HVGDsdsizXL8LvEga4tgkQztpHhHYutc2629WqAZ8enT5ePwRdxp/86
         sMYRmmeFusUz0Meaaey/Q2du7Df9Ou69oR6XnoCpgzOtJPc12TrR6GxR7WuvTzMjvl7p
         tCVjjwQCSNL/edZcUKMg9yc9gtHbGrf2yTqhk7u3ibGEXM5FhO/siy+jGmNNiZlI6o2v
         g5KPQO+eB2zIY6+BNqwt6+YSGEFrwOki0BZBcFHgB+oQi9WbXBbntmEX3DUN9vyCLdKI
         nYbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Pty6C2nrLJxasEr51wGRq0lQ2nqP2bOfYIiMHMUP8D4=;
        b=K5W7LXSyKrW6r3PHPnntwVv3Xtxv4dO59xryKl/5rksh4Iyk9WwkRmdKkto0j993aS
         xXNNnreTr30YlbXBTM6Tyy/QEKdwaaE7b2N0HdGAkDAXm/FBwttkns5YpQWIEEtSU7g7
         LIIqAXjoQSSmWAhMxwAhHxpZz7lmSIVX4EhZUbl68r8OCBCiDe90NJN0xw1+K6MSFCHH
         HsI4M/Ooh+H3ndg9eJMGj6HfUkIqn9KFA4Mjk8rkwN+PLpxRd44mJP7dXOAiN+3z0E6E
         7zr8T+4IMYuXbQM+Aga4XovmOSO/vgRn5AXar+C/DfdZ+01ITgca7qAhzqxiiDmIjbM5
         ttMg==
X-Gm-Message-State: AOAM531kPTFc0UT8vPdggQqusP7g1U8hx2ytaQOJaWsOBt7R1fHNcis5
        BUxivEDl5te/IMyzLoIUtXcCmmnNdloAkSEmxb0X2Q==
X-Google-Smtp-Source: ABdhPJz7f2ctcvowLB8POxF7O44Xzl0pcHw/Wjh4YQjO4B8g4KIXAQLFcp5F4S8dtKLWiqJILKDI+ym+AVAN8VG54Qc=
X-Received: by 2002:a63:d010:: with SMTP id z16mr4949420pgf.381.1589997399878;
 Wed, 20 May 2020 10:56:39 -0700 (PDT)
MIME-Version: 1.0
References: <202005201012.pqmB8hA5%lkp@intel.com> <20200520155352.GB3184088@rani.riverdale.lan>
 <CAMj1kXGNmDPQRCCtRYFRa+0NW9kADnx327FzPbNge+MU+NFoVg@mail.gmail.com>
 <20200520173425.ovn4kvv2cvkdlrnn@google.com> <20200520173926.GA3365034@rani.riverdale.lan>
 <20200520174100.GB3365034@rani.riverdale.lan>
In-Reply-To: <20200520174100.GB3365034@rani.riverdale.lan>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 20 May 2020 10:56:28 -0700
Message-ID: <CAKwvOdns1LkmPNAGcOZRdXxD_2fTgbYzr0DndvsTVL-Zuuowgg@mail.gmail.com>
Subject: Re: [efi:next 22/40] ld.lld: warning: vsprintf.c:(.discard.unreachable+0x0):
 has non-ABS relocation R_X86_64_PC32 against symbol ''
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Fangrui Song <maskray@google.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        kbuild test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        Philip Li <philip.li@intel.com>,
        Chen Rong <rong.a.chen@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, May 20, 2020 at 10:41 AM Arvind Sankar <nivedita@alum.mit.edu> wrote:
>
> As an aside, how does one (should I) get onto kbuild-all? It keeps
> bouncing me as a non-list member currently.

Philip Li <philip.li@intel.com>
Chen Rong <rong.a.chen@intel.com>
are the two folks I always reference for 0day bot related questions. I
haven't seen bounces, but I also don't recall subscribing to any
related mailing lists.  Maybe I was added to one?
-- 
Thanks,
~Nick Desaulniers
