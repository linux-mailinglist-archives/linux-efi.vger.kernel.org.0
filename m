Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A089D16678A
	for <lists+linux-efi@lfdr.de>; Thu, 20 Feb 2020 20:52:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728889AbgBTTwB (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 20 Feb 2020 14:52:01 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:43943 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728448AbgBTTwA (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 20 Feb 2020 14:52:00 -0500
Received: by mail-qk1-f193.google.com with SMTP id p7so4724299qkh.10
        for <linux-efi@vger.kernel.org>; Thu, 20 Feb 2020 11:52:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=p4Kyq2J+y27D1KBMzqk+kIt+doNXRpHrJuQKS1zivHE=;
        b=g+O4wLoSrWAsfJrrTSvwuLW6lU7Xmq02sN83eALsY39QV8aPDMyJAzSBVq4lUd6jLX
         RudpeD1iMsz3QziwZx3fZE7o25msPv/m1KhBhaqFzVqwdTLidIPKx4xYLAF4mwnqwXpZ
         HNz0u0DmHhHSJfVYikJuwgDj0X9Zuj6ZUSzijjVO/Y0RLIEn4io9JHxNd1AWJbUThjyQ
         KzbNKXrBBEBZh6FuObmQ72F9w7VY8SZvz/Z4tbbHKEEgI52gP6fanwaAeCNSwW6db82N
         1VWWO+9sfl+veOv+RhD3R9ZSfOb0jiCmB4kZWVzwo58m2KTEsyQ8mXNp57AuOijdNe46
         jqFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=p4Kyq2J+y27D1KBMzqk+kIt+doNXRpHrJuQKS1zivHE=;
        b=tJJfsBg6Vglnxy5PYflR0efRlIPRrKlDwJMk4QcG5A/uWGM2Qi09z/XRzZTkkDmedX
         +M3HJyseOSYEMI0rsTkDJfD/Fd0QD0Yg/BNzN6Vew+xrJmpyUa5bf7I8zh9Xl+W4+j5B
         y+cPl5rkuQl6qJB+rfe/3UaoaT03dKr+CPhmeLLwDC0T/H0xLA8/1lMSBbWJUFmcL2ZA
         DjlO3aTD3ZcDHVXJAyCqcBt39k1rqgM+SsROudrqN5TJk4KLhl4pfX+VcXPGwmqRQEgn
         fP/iove/YCEztILV2JKQJtLAzXBPSGdtACSXt+w9PL313Yl5EdUte8R84knrF/SMOHce
         v1Uw==
X-Gm-Message-State: APjAAAVoVZuoenk7mN9Jgnz/Tk4Q/ed0j3zVFhlrAxqRjhHCuVhJGcP9
        a8in2EVQDnSwskZKNEpKxyk=
X-Google-Smtp-Source: APXvYqx65DYBYWmlpbfL1Ur1lbOk/F9BJxqeYvBcB9Lu5mUgFQvbsro5w7veCX48mn48wOtjDYairw==
X-Received: by 2002:a37:6752:: with SMTP id b79mr30777449qkc.224.1582228319561;
        Thu, 20 Feb 2020 11:51:59 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id d20sm315528qto.2.2020.02.20.11.51.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2020 11:51:59 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Thu, 20 Feb 2020 14:51:57 -0500
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        linux-efi <linux-efi@vger.kernel.org>,
        Laszlo Ersek <lersek@redhat.com>,
        Leif Lindholm <leif@nuviainc.com>,
        Peter Jones <pjones@redhat.com>,
        Matthew Garrett <mjg59@google.com>,
        Alexander Graf <agraf@csgraf.de>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Heinrich Schuchardt <xypron.glpk@gmx.de>,
        Daniel Kiper <daniel.kiper@oracle.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>
Subject: Re: [RFC PATCH 1/3] efi/x86: Use symbolic constants in PE header
 instead of bare numbers
Message-ID: <20200220195157.GA2483987@rani.riverdale.lan>
References: <20200220110649.1303-1-ardb@kernel.org>
 <20200220110649.1303-2-ardb@kernel.org>
 <20200220172831.GA2417225@rani.riverdale.lan>
 <CAKv+Gu_QiXsJyR0X4au+r75DFoQmSUp38+J7BuD3HAH+rJ9gHQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKv+Gu_QiXsJyR0X4au+r75DFoQmSUp38+J7BuD3HAH+rJ9gHQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, Feb 20, 2020 at 06:32:39PM +0100, Ard Biesheuvel wrote:
> On Thu, 20 Feb 2020 at 18:28, Arvind Sankar <nivedita@alum.mit.edu> wrote:
> >
> > The .text section contains data as well. Shouldn't it be marked
> > IMAGE_SCN_MEM_WRITE also?
> >
> 
> Another good point. For ARM and arm64, I actually changed this into
> split R-X and RW- sections, in case the loader decides to honour these
> attributes (which it should imo)
> 
> So yes, we should either add IMAGE_SCN_MEM_WRITE, or add a .data
> section (although we probably don't have the space for that).
> 
> Another thing I wondered was whether we really need the .reloc
> section. We don't have one on ARM, and it works fine with the existing
> EDK2 loader.
> Peter: any idea whether the issue with .reloc you pointed out to me
> the other day still exists in EDK2 today?

Is there any reason we couldn't combine .setup + .text as R-X, then
.reloc, then .data + .bss as RW-? That would leave room for the new
.compat section then even without removing .reloc.

Although if the loader actually honored the non-writable setting,
efi_relocate_kernel has to be done unconditionally. It currently happens
to be unconditional if you come in via PE loader, since we don't set
ImageBase to tell it our preferred address, and even if we did, the
existence of .setup means startup32 isn't at that address.
