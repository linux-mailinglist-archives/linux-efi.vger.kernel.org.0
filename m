Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 34D5E14338B
	for <lists+linux-efi@lfdr.de>; Mon, 20 Jan 2020 22:55:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726958AbgATVzy (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 20 Jan 2020 16:55:54 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:54897 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726752AbgATVzy (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 20 Jan 2020 16:55:54 -0500
Received: by mail-pj1-f65.google.com with SMTP id kx11so337849pjb.4;
        Mon, 20 Jan 2020 13:55:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yz+RC08LXcOfqh007ME4eF+FjZEItC+jHzaYRevoImc=;
        b=hM2yFnlG+mX/xO5k3PyRGynk4RsP3WHWyFHM3oFVKoTwzv5zVOfHnS4ePT+xyCuDaM
         gj/Tjv+zB/VhLCk4AzOjK+Nz8HDCD5c33B+TRiuJFAIc/8RPo6CCxhbq12YOqID6cvWG
         GksiCOXgSojOnCOTJX4TZdhbsWMWdnnp/H92ZrzNEdjInfeORNj3klX/DtdqgSbgHRrR
         UTcyBQq1Kx7pUrlg3qQCekUmOVNUskDlnpfXWkEcuJfdDqnS2+XKTcVG6in2H4HOH/3u
         RfWjIc65RtZEhFhuZgqgk4JZt6LgQ1K4O1fq6uYPhOgzKhv2KvPs+ykau1AHuMbGLnn+
         41hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yz+RC08LXcOfqh007ME4eF+FjZEItC+jHzaYRevoImc=;
        b=ZTYbhD/sQiB50AowZ1DLW401W8NufrdTR9A9y1bFh9WcfO/9KEZF7pRAb8JP7KHrF/
         aHDqtFXJ6zdc7tlwWDXgIxJCArUB390ZP1/t7aJfaELrrslZkMYcokK8L6+03QgtiKVJ
         CXwBvMYA6bVMuMsqudh0mht5UhP53y77bUGthg4SVi/h6029uRA+NjIb+yB6Vv8VFgCo
         Rk0BDG+nBytjIqwiEoFn5VsZwSAg9NEi0awnLsKaMKs7vS75kXWHM53Ddrvj1rTTD6Gm
         RLDaCey9x1DMFF50KslCySLH5rbfDgSfymVa+cVXw2Ze2zQ477KLodJ5OzFgukFFHKXi
         m1qA==
X-Gm-Message-State: APjAAAU1fcVF2mgI3Rk9zBSZr6cJY+Vq5P9h5iVRMyripT9LYaCsYwjm
        /8viGJBRvMJcp2dAyM2S+HAZF5MQKjLNSPklb0E=
X-Google-Smtp-Source: APXvYqwAnMrdxUof1ypYQ1jFBbFXx8VyehJMjwx/BCsTqeK5Gfkg8wWJe1FrprUGSneVGrFNyiUIwzDYiz40QVv6Uk0=
X-Received: by 2002:a17:902:a9c7:: with SMTP id b7mr1836647plr.255.1579557353372;
 Mon, 20 Jan 2020 13:55:53 -0800 (PST)
MIME-Version: 1.0
References: <20161202195416.58953-1-andriy.shevchenko@linux.intel.com>
 <20161202195416.58953-3-andriy.shevchenko@linux.intel.com>
 <20161215122856.7d24b7a8@endymion> <20161216023213.GA4505@dhcp-128-65.nay.redhat.com>
 <1481890738.9552.70.camel@linux.intel.com> <20161216143330.69e9c8ee@endymion>
 <20161217105721.GB6922@dhcp-128-65.nay.redhat.com> <20200120121927.GJ32742@smile.fi.intel.com>
 <87a76i9ksr.fsf@x220.int.ebiederm.org> <20200120224204.4e5cc0df@endymion>
In-Reply-To: <20200120224204.4e5cc0df@endymion>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 20 Jan 2020 23:55:43 +0200
Message-ID: <CAHp75Veb02m3tU9tzZe912ZmX5mdaYkZ90DD67FVERJS15VsXw@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] firmware: dmi_scan: Pass dmi_entry_point to
 kexec'ed kernel
To:     Jean Delvare <jdelvare@suse.de>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Dave Young <dyoung@redhat.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        kexec@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, Jan 20, 2020 at 11:44 PM Jean Delvare <jdelvare@suse.de> wrote:
>
> On Mon, 20 Jan 2020 10:04:04 -0600, Eric W. Biederman wrote:
> > Second.  I looked at your test results and they don't directly make
> > sense.  dmidecode bypasses the kernel completely or it did last time
> > I looked so I don't know why you would be using that to test if
> > something in the kernel is working.
>
> That must have been long ago. A recent version of dmidecode (>= 3.0)
> running on a recent kernel
> (>= d7f96f97c4031fa4ffdb7801f9aae23e96170a6f, v4.2) will read the DMI
> data from /sys/firmware/dmi/tables, so it is very much relying on the
> kernel doing the right thing. If not, it will still try to fallback to
> reading from /dev/mem directly on certain architectures. You can force
> that old method with --no-sysfs.
>
> Hope that helps,

I don't understand how it possible can help for in-kernel code, like
DMI quirks in a drivers.

-- 
With Best Regards,
Andy Shevchenko
