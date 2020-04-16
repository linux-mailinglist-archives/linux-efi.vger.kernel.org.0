Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7F8E1AC7A0
	for <lists+linux-efi@lfdr.de>; Thu, 16 Apr 2020 16:57:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405010AbgDPO53 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 16 Apr 2020 10:57:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:41308 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728463AbgDPO5Z (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Thu, 16 Apr 2020 10:57:25 -0400
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8F2CE22250;
        Thu, 16 Apr 2020 14:57:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587049044;
        bh=V0otI6gVyfDSkDi9pLuqdj9z9fHD1hVrU6r4MDAkjaU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=eH5cwJ6Vemlq8tWwK/OI3bNQgP5TkacIgI9R7K7Ci9iaafK3wmZ1z5nIWGI8/MBnz
         KXsK5TfkIkqYJDqTj17R6leB9fZfjGtAHPkUG3X5ad08PfSEsmIaYwJnabN+rt5414
         LLTsKgZyeKV1nE2tfNkkvkDbjmUre6zUShW/6Fso=
Received: by mail-il1-f182.google.com with SMTP id u5so7183316ilb.5;
        Thu, 16 Apr 2020 07:57:24 -0700 (PDT)
X-Gm-Message-State: AGi0PuZlzxmKXYaEvrjB7eOG4NTlP+w4vqL/pjP0JGuKetdOiHvhVDcK
        bKhpqpWNGCoSokMnbIVsCZ9q6ndXCx5+e5auwKo=
X-Google-Smtp-Source: APiQypJOghpmilZOFUzSx9f9kqFywMdVN+qnaJPXwQkShHHhsviduS/U5YL3G4CG0thdgj8z1jRPR7OHKPMe596W/oQ=
X-Received: by 2002:a92:991c:: with SMTP id p28mr6599337ili.258.1587049044044;
 Thu, 16 Apr 2020 07:57:24 -0700 (PDT)
MIME-Version: 1.0
References: <eb0d88d0-879e-c500-261e-69c76fb68a89@linux.intel.com>
 <CAMj1kXGGdwuP6X5jvbqmjsP2+bZ7CoJKZ5-WVoPYEjq9HTjuDA@mail.gmail.com> <9ae0c751-5024-6eda-ca78-80cfd1ed066f@linux.intel.com>
In-Reply-To: <9ae0c751-5024-6eda-ca78-80cfd1ed066f@linux.intel.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 16 Apr 2020 16:57:13 +0200
X-Gmail-Original-Message-ID: <CAMj1kXH+9wM5xwm31YE=CY6WUyeCt66r-3g5SohisQPcz3x-Kg@mail.gmail.com>
Message-ID: <CAMj1kXH+9wM5xwm31YE=CY6WUyeCt66r-3g5SohisQPcz3x-Kg@mail.gmail.com>
Subject: Re: Regression with commit 0a67361dcdaa
To:     Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, 16 Apr 2020 at 16:56, Jarkko Nikula
<jarkko.nikula@linux.intel.com> wrote:
>
> On 4/16/20 5:36 PM, Ard Biesheuvel wrote:
> > On Thu, 16 Apr 2020 at 16:35, Jarkko Nikula
> > <jarkko.nikula@linux.intel.com> wrote:
> >>
> >> Hi
> >>
> >> v5.7-rc1 hangs in early boot on an Intel Atom based prototype hardware
> >> while v5.6 boots fine. I bisected the regression into 0a67361dcdaa
> >> ("efi/x86: Remove runtime table address from kexec EFI setup data").
> >>
> >> v5.7-rc1 caused a reboot loop on another Intel Core based prototype HW.
> >> Reboots also on top of 0a67361dcdaa but boots fine with that commit
> >> reverted.
> >>
> >> Our test system uses kexec to boot the test kernel. These two machines
> >> got regression with v5.7-rc1. We have also others that boot fine.
> >>
> >
> > This should already be fixed in Linus's tree. Please report back
> > whether that solves your problem or not.
> >
> Ah, I forgot to pull & test before bisecting...
>
> Yes, both machines boot fine with the HEAD 00086336a8d9 ("Merge tag
> 'efi-urgent-2020-04-15' of
> git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip").
>


OK, good to know. Thanks for confirming.
