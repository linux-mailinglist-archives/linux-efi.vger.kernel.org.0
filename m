Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB2C711DAF9
	for <lists+linux-efi@lfdr.de>; Fri, 13 Dec 2019 01:13:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731295AbfLMANx (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 12 Dec 2019 19:13:53 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:42956 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731248AbfLMANw (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 12 Dec 2019 19:13:52 -0500
Received: by mail-qk1-f193.google.com with SMTP id z14so329635qkg.9
        for <linux-efi@vger.kernel.org>; Thu, 12 Dec 2019 16:13:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=D9BfqK0MevFld3So5Km6d6+WB+Sh/tXgKU1sah2nPJ4=;
        b=mgtWgCgnrj6GFhyVFSk7Uz/LnUyO8tKSwxByCD/NblXtwlFElwmtX6ZA6Pj8uB3GjE
         xi26cSxHRWS0fihZvxmcFjhPcqr8nLb4y8a9RSSSP91urzhmCk6W96mCsXpJiws1xOL3
         WCByyUhfsONceFe+ynedBy1r/zR3AJyu03Q9FUTLf+UWro4VS7EJtFvbi9iF5SL44MDY
         tf9GZhKFNOldS9mGW3LVQgduyxbWmRdgHybuQTagoSJcVo6p4fnjk+xlgwCFu91xOjPf
         W3YfBqRTfDYZtHbeIeryPxuyda8Q4a6JE2OYSGPfZPNYwuikt8nq8SnpmIXirPcuOLcJ
         jdig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=D9BfqK0MevFld3So5Km6d6+WB+Sh/tXgKU1sah2nPJ4=;
        b=PDZJBnMI7DDQ3eoGYRVosPrOqOI+E9HRiTFg/Pjm0HOCumouM2KTe6zOxpuE//QLjQ
         ZUe3YzRhbW+tVq5bv/oPmGUSw2O3j+/Tz987EWA4/tEmbtfhfdRpZbCX2dJFAkGU55n6
         HDphX3bX2zJAa9yTNQFQG9snR9hq7xb156AuTUDLl+JGynqzPJ8vjBJexK+5jtMrwcDw
         Sko6cal5gK7ypTnMszF5uOQGwBRXncJq+vmNpGqogEoegqrqdqF3C9gsFMZTuX5L6D8D
         xKUQqpsgkOFajljrlxTYfFMVFdJht1Tl3jcq5qsz9/ABp3qGQTKs6l8SiSkahpsPilA0
         JD7A==
X-Gm-Message-State: APjAAAU2IQTipfRb0zXhemnxXBtszouDo3x63yQXv0bjE48v4kULhzJy
        RAIfgQoVgAmBJA/cboEzRaU=
X-Google-Smtp-Source: APXvYqzoAn83L+XpkRPcfJWZk8Fjrwo9/47b5+vvb+hIAbiXQa8Yv6NCQE0Xx4jRzuzMl+Y2JAmGBg==
X-Received: by 2002:a37:ae47:: with SMTP id x68mr11192488qke.214.1576196031701;
        Thu, 12 Dec 2019 16:13:51 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id m27sm2833152qta.21.2019.12.12.16.13.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2019 16:13:51 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Thu, 12 Dec 2019 19:13:49 -0500
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Ard Biesheuvel <ardb@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>
Subject: Re: [RFC PATCH 0/5] efi/gop: Merge 32/64-bit code
Message-ID: <20191213001349.GA5469@rani.riverdale.lan>
References: <20191212213443.24128-1-nivedita@alum.mit.edu>
 <CAKv+Gu_EDan06Cm+LC3Rr8RZhrGsRELwLQWUOLHyzhToenuG8Q@mail.gmail.com>
 <20191212223516.GB10385@rani.riverdale.lan>
 <CAKv+Gu9TAzkRpyM21zAQRy61ywVHyRucTa9EX_urkB2ZQzsf6Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKv+Gu9TAzkRpyM21zAQRy61ywVHyRucTa9EX_urkB2ZQzsf6Q@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, Dec 12, 2019 at 10:38:29PM +0000, Ard Biesheuvel wrote:
> > > > Patch 5 is to make sure that we don't wind up with a >4G framebuffer on
> > > > a 32-bit kernel that can only address 4G. I'm not sure if this can
> > > > practically happen on anything that we can run a 32-bit kernel on, but
> > > > UEFI specs the framebuffer physical address to be 64-bit even on 32-bit
> > > > systems, so I figured we might as well cover this edge case.
> > > >
> > >
> > > This cannot happen. The 32-bit kernel can only run on 32-bit firmware,
> > > which cannot create mappings above 4 GB, so in that case, fb_base is
> > > guaranteed to be 32-bit addressable.
> > >
> > Is that still true with PAE?
> 
> Yes
> 
> > i.e. is it conceivable that some system
> > uses the 36-bit address space to map PCI memory to above 4G physical
> > addresses, or can PAE only be used with actual RAM?
> >
> 
> PAE can be used with anything, but UEFI won't map anything in places
> where it cannot access it itself. (UEFI mandates a 1:1 mapping)
> 
At least on my system, the framebuffer isn't mapped by UEFI though --
it's not part of the EFI memory map.
