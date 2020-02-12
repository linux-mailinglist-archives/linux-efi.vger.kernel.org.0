Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 915AD15B322
	for <lists+linux-efi@lfdr.de>; Wed, 12 Feb 2020 22:57:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727692AbgBLV5X (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 12 Feb 2020 16:57:23 -0500
Received: from mail-qt1-f177.google.com ([209.85.160.177]:47093 "EHLO
        mail-qt1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727564AbgBLV5W (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 12 Feb 2020 16:57:22 -0500
Received: by mail-qt1-f177.google.com with SMTP id e21so2827143qtp.13
        for <linux-efi@vger.kernel.org>; Wed, 12 Feb 2020 13:57:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HF/4PzMNjK5Tj6IHN/5C6uBOuB6Z7IVbPYbhJA3wDyc=;
        b=fQlXRLxnktvmmjeAxU1jKblc3rZeVLXCwpdEzSIID60F6mQgP1a58KBtbZmsEVHrmQ
         //mKgnl0CLZqK7f6+Mar1Eh7mBgyBghLGap69uh79G+IVwt0W9Gx+lbWXOD+uW0IfwbK
         6o6r8CI2aO5lCceAQzj6TJlMs1A/GATaJ0sDBqZT5HmDL9DyKmcEkKPLHWngg/TZekfc
         B+RXu3kVFV3Di4cF6c5nuoSuUy6Neh88TmJftZBk4lXuu8fBQboCuXIUyB1xYQSEvnz7
         wtOraVvi3H28KVwaq0JTmPUq6oCRL/HwV2hmTSkeKp/8faZJtMagy9zxfwSYPLHkengc
         G52A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=HF/4PzMNjK5Tj6IHN/5C6uBOuB6Z7IVbPYbhJA3wDyc=;
        b=M7M7TcTp+HsxcVwc7Q+z+BNB1sjOTZVI+qe+wAdWTCcDSk9e8J9Y04i3ttp7lCKOm0
         1x25inNtVxfDvZXl649QYj/71DFFJnZv5Qlh+FQ7LVDaV22N94t1So805Rt/mComhpVA
         G+M131FcWS6xnrLAp+aijgNeLYI3qHtrvo4Fqz+GX+c8mYuuabLhgwow7upmcjEj/46w
         FAmnUWZTuwnv87sv2WbRbRGU2uC0+GbTkyzI3gFLD4wBnE2ARUDBQoCAJl6CKvOJXC0e
         u4ksW4IJ9PBp2NmQQHpy5UCBz0XW9fcFVkbLERX+fh1vcfeazHhkmEFCQB7C5xOCn91U
         B13Q==
X-Gm-Message-State: APjAAAXHMCboYG9dM8+7aLHSYuZRAZ/L4xJGSQ9HtJqn+0atF4hPgZw5
        SM2yBTcnilQZVZ547mUc15g=
X-Google-Smtp-Source: APXvYqzxoVPwmvuKvD9wfat64vTO2+jNEzlo+kxL7foPHUZ4WM0hjg3RxB7U8lmWINFEvDOJRQnFCA==
X-Received: by 2002:ac8:1a8c:: with SMTP id x12mr9331816qtj.297.1581544641524;
        Wed, 12 Feb 2020 13:57:21 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id y83sm137427qkb.40.2020.02.12.13.57.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2020 13:57:21 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Wed, 12 Feb 2020 16:57:19 -0500
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        linux-efi <linux-efi@vger.kernel.org>
Subject: Re: New EFI thunk alignment WARN_ON in 5.6 triggers multiple times
Message-ID: <20200212215717.GA958135@rani.riverdale.lan>
References: <aaf658ab-82ff-4a35-2984-77150924d3a7@redhat.com>
 <CAKv+Gu9fh_reYp65QXCeL4X3iovrCQFGNZWS3jMkpveZLgre-A@mail.gmail.com>
 <ab45ebd9-b2c3-d2f9-8947-be95aaab80bd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ab45ebd9-b2c3-d2f9-8947-be95aaab80bd@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Feb 12, 2020 at 04:00:24PM +0100, Hans de Goede wrote:
> Hi,
> 
> On 2/12/20 12:53 PM, Ard Biesheuvel wrote:
> > 
> > 
> > It seems that the purpose of the alignment check is to ensure that the
> > data does not cross a page boundary, so that the data is guaranteed to
> > be contiguous in the physical address space as well.
> > 
> > So in that light, the fix is most definitely wrong, although I am not
> > sure how this is supposed to work generally.
> 
> I'm not sure that is what it is trying to check, if that is what it is
> trying to check then the code is certainly wrong.
> 
> Let me first quote the entire check:
> 
>          /*
>           * A fully aligned variable on the stack is guaranteed not to
>           * cross a page bounary. Try to catch strings on the stack by
>           * checking that 'size' is a power of two.
>           */
>          bad_size = size > PAGE_SIZE || !is_power_of_2(size);
> 
>          WARN_ON(!IS_ALIGNED((unsigned long)va, size) || bad_size);
> 
> AFAIK EFI is using the identity map, and the kernel stack is
> physically contiguous, so crossing a page boundary should not a
> problem. Also notice how the bad_size thing is talking about
> page boundary crossing, but the thing triggering is the
> IS_ALIGNED check. AFAIK there is no requirement for a struct, e.g.
> an UUID (which is the problem here) to be aligned to its size,
> it just needs to be 8 byte / 64 bit aligned, which it is yet
> the IS_ALIGNED check is failing because it is checking for
> a larger, in this case twice as large, but possibly it will
> end up checking for a much larger alignment.
> 
> As said I'm not exactly familiar with the alignment requirements
> but the current check certainly seems wrong.

If VMAP_STACK is enabled, the stack pages may not be physically
contiguous. So the check is trying to warn about all cases where the
object might cross a page boundary and so not be physically contiguous,
even if the current call is ok because it doesn't cross the page
boundary.

It should probably also error out rather than making the call if it is
actually the case that it spans non-physically contiguous pages.

However, I'm also getting confused about how mixed-mode works at all if
we have more than 4Gb RAM, which it seems we want to support as we take
pains to allocate a stack below 4Gb for the thunk. But in this case, the
kernel text and stack could be above 4Gb physically, so rather than
using a 1:1 map we'd need to find some space in the low 4Gb of virtual
addresses to map those, but I don't see where we do this? Also, that
dynamically allocated variable_name could be above 4G as well.
