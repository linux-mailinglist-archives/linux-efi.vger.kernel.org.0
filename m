Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9ACBF424E0D
	for <lists+linux-efi@lfdr.de>; Thu,  7 Oct 2021 09:23:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240248AbhJGHZo (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 7 Oct 2021 03:25:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232512AbhJGHZo (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 7 Oct 2021 03:25:44 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AC72C061746;
        Thu,  7 Oct 2021 00:23:51 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id b8so19459581edk.2;
        Thu, 07 Oct 2021 00:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=T5xl44owx81ny68TVoXh/UmOxxj+RahZDm9p7btDBj8=;
        b=fenev9dYOxuLufnOiVztNDU2yBt/A8/CrPULUuN7XvVamxXl6lrOyFElU48oWCnOuS
         AEqjLoxUOQ5mKd4GrnFqJOMWegly3Z9RqR0S0VNH4NRcVT4fDghbWiLI/uyCkNi/e1PT
         Kl83iahGjtX3sdlDbVdHLERPHipaVg+X+O1YoVYlCttBomvM+uDPfRNKUzRxV98DyOoA
         E5s/lJ09HZx4O/F6gJ4JTrSUIRS4V4ZJfAdvrfzLUWtzDwxSeT+h2tTV/FhxIM2iMPCE
         KgNVSRFFP0FpZ1Wb5mAvO0S9Bbs4Qx9vjlGnGQb98V7o9KX83h0nkgIPYBEEneWGZblg
         rbDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=T5xl44owx81ny68TVoXh/UmOxxj+RahZDm9p7btDBj8=;
        b=GhNqYnw9Zxao9yyAIiX3aUp2yFL9wN3OPhpBlyGFixs9si0qQke419XqsqJpX+amLL
         yuv0g6xww6yJEFbypioFmK0P6JLV+z8/kkRPqSw2g3Uex6dFOVYokh5l1w0FX7RHFw1U
         x88uVfKni9RROBEHluIlEnwY3VS9nokvEyc58A65xotgSjwqaXDTFDoFvEhqP1bbF8K6
         5XUbG4G9g4T06LtKZ2h7YZ3JSy3GReyrVFWX55L/UbrIJV0o6ANnctit8Hu++z9Galw5
         YkB/nMqn9GfD9OxHRCOawNNzMH47Yb9/jPYQIzdY0sjwXm3Ac2kajeCqEHUiqc7sBu1R
         DONg==
X-Gm-Message-State: AOAM5316zgTSK29lPFezuy01u5u53FXlAvFFqS+NR299VmKiAzsmqL7q
        bGX01HzzDh0RrEGfbH704K7TsGBKbV0nxwyh+Fw=
X-Google-Smtp-Source: ABdhPJyvJ0nzg5VZ7Uc7uXogp6HhD0zD99RRYAjAMTpsdOIwlKmgV//iEQNI9qhGXWK4MBEUKDsH+7B8TYgNN3R9f30=
X-Received: by 2002:a17:906:2887:: with SMTP id o7mr3577480ejd.425.1633591428659;
 Thu, 07 Oct 2021 00:23:48 -0700 (PDT)
MIME-Version: 1.0
References: <YLss6ZNPMIXleLLF@dhcp-128-65.nay.redhat.com> <YL5HvUqtsDXx5CzM@smile.fi.intel.com>
 <YL5U/zSb50SnbLgW@smile.fi.intel.com> <YL9hxPdPj0dYMyaD@dhcp-128-65.nay.redhat.com>
 <CAHp75VcPuf6BLGf7Y3RO2M-gHMFZMTeb4ftnj_tbGS4TxvThxA@mail.gmail.com>
 <YMCsSqzmG4jb1Ojo@dhcp-128-65.nay.redhat.com> <YMQ62d1EFFjRcv6w@dhcp-128-65.nay.redhat.com>
 <YMd39tIPercgljll@smile.fi.intel.com> <YMeM1Xee9Yg3j21D@smile.fi.intel.com>
 <YMeRiDMet2JyOV4P@smile.fi.intel.com> <YV3Oonc5s3UpzRq0@smile.fi.intel.com> <CAMj1kXHjXcFePeRWDtxZnC6eHEeELA6kZXOU=sA9oDZ1HzW_Vg@mail.gmail.com>
In-Reply-To: <CAMj1kXHjXcFePeRWDtxZnC6eHEeELA6kZXOU=sA9oDZ1HzW_Vg@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 7 Oct 2021 10:23:12 +0300
Message-ID: <CAHp75VdLLZsJnektx+n=BGvGeaogN0r=viNJpbR-au5RUURi9Q@mail.gmail.com>
Subject: Re: [PATCH v1 0/2] firmware: dmi_scan: Make it work in kexec'ed kernel
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Dave Young <dyoung@redhat.com>, Jean Delvare <jdelvare@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        =?UTF-8?Q?Javier_Ti=C3=A1?= <javier.tia@gmail.com>,
        kexec@lists.infradead.org, Eric Biederman <ebiederm@xmission.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        Matt Fleming <matt@codeblueprint.co.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, Oct 7, 2021 at 10:20 AM Ard Biesheuvel <ardb@kernel.org> wrote:
> On Wed, 6 Oct 2021 at 18:28, Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> > On Mon, Jun 14, 2021 at 08:27:36PM +0300, Andy Shevchenko wrote:
> > > On Mon, Jun 14, 2021 at 08:07:33PM +0300, Andy Shevchenko wrote:

...

> > > Double checked, confirmed that it's NOT working.
> >
> > Any news here?
> >
> > Shall I resend my series?
>
> As I said before:
>
> """
> I would still prefer to get to the bottom of this before papering over
> it with command line options. If the memory gets corrupted by the
> first kernel, maybe we are not preserving it correctly in the first
> kernel.
> """

And I can't agree more, but above I asked about news, implying if
there is anything to test?
The issue is still there and it becomes a bit annoying to see my hack
patches in every tree I have been using.

-- 
With Best Regards,
Andy Shevchenko
