Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A456815CAA9
	for <lists+linux-efi@lfdr.de>; Thu, 13 Feb 2020 19:47:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727722AbgBMSr4 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 13 Feb 2020 13:47:56 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:33740 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725781AbgBMSrz (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 13 Feb 2020 13:47:55 -0500
Received: by mail-qk1-f194.google.com with SMTP id h4so6742482qkm.0
        for <linux-efi@vger.kernel.org>; Thu, 13 Feb 2020 10:47:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ItcHxmvwXWY22Frq93yy83FEgztrFUHu+KYy0gKPrtU=;
        b=N4uAGNRQul1USMZvgbzEha2JgQY4DeRIP4RNfbL9Ph/eCKQqlnGRBa5xV8YoKO1nVu
         jX1m1AeoVYk9R5ZhdTU1LXeqWRNVk7U0/4IsQHtLFZSqpdUonvqhvwYKZNOvDF3NMhiY
         5LqS1M/8Q9AUaDBn6mCAPXYVa7BGaSXxp0w3kYBfikUYbFB3lPbKrp+/9MHbM6m9o9Cb
         CSssK5NTP27/0qRVWRfqpK2eVxW+JT0a7HoOiIx2+y7GazUmazw30C/ETo/dHkEfhFAB
         pvrKcGguYqZGJhb05V+GCF1GFhidyX2+AWjyhMUObq2pyLisLVXIo1Glui+5DjkxJCRl
         UVnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=ItcHxmvwXWY22Frq93yy83FEgztrFUHu+KYy0gKPrtU=;
        b=YN72BhL9UZhdSlsLrpSmt8+M652NRvkGSVnhgc/bLYn5Gy6sZciZpcNrkdV6+tVAU2
         3VNtFsjhXwsdNmbGjcb/0q6+pYjw7trc7Sc7sIRweqNQUzSNnb30HyflrFz7oisFAmAR
         20w1pDzCDaJ77oSug2FuaBvbWpy7eG8aCrfLpbDVLbK6WBls2OxCtXR2zG68aCNhauT2
         t2cbGB1LLcJHcXSgUm/G0iXWo9gZiU1wkBa3GmjAU5wX8vUsNQL1AjweuSf0MYT1famB
         b2kpSqZrIDONWpcXAhLvPkgLiIDT4VoSNE71Mjy+vYEBbn5fvODerrEL+ZeLbPIKN3ue
         oabQ==
X-Gm-Message-State: APjAAAXE3xOu1y/6LkPFCSPkSC5FSR4iF23rYMk7uGQkB8MKbVWwX/gN
        OUl0jfwbfMyEv1+uRZs4Ono=
X-Google-Smtp-Source: APXvYqz3d1t4QHve0cTl9mgE5VkQtHXLK+r3RlU7AQCkpBiT3mb5Mbx8B0EKdCfdg719bNTZQK4w0w==
X-Received: by 2002:a05:620a:1134:: with SMTP id p20mr17213053qkk.33.1581619674400;
        Thu, 13 Feb 2020 10:47:54 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id w134sm1740928qka.127.2020.02.13.10.47.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2020 10:47:54 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Thu, 13 Feb 2020 13:47:52 -0500
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        linux-efi <linux-efi@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Laszlo Ersek <lersek@redhat.com>,
        Leif Lindholm <leif@nuviainc.com>,
        Peter Jones <pjones@redhat.com>,
        Matthew Garrett <mjg59@google.com>,
        Alexander Graf <agraf@csgraf.de>,
        Daniel Kiper <daniel.kiper@oracle.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Michael Brown <mbrown@fensystems.co.uk>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [RFC PATCH 0/3] efi/x86: add support for generic EFI mixed mode
 boot
Message-ID: <20200213184752.GA1424509@rani.riverdale.lan>
References: <20200213145928.7047-1-ardb@kernel.org>
 <20200213175317.GC1400002@rani.riverdale.lan>
 <CAKv+Gu-78w=gs+D-eS5iBX7e3zL57XBOe1vdW=Bkk=EcA+_FQA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKv+Gu-78w=gs+D-eS5iBX7e3zL57XBOe1vdW=Bkk=EcA+_FQA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, Feb 13, 2020 at 05:55:44PM +0000, Ard Biesheuvel wrote:
> On Thu, 13 Feb 2020 at 18:53, Arvind Sankar <nivedita@alum.mit.edu> wrote:
> > As an alternative to the new section, how about having a CONFIG option
> > to emit the 64-bit kernel with a 32-bit PE header instead, which would
> > point to efi32_pe_entry? In that case it could be directly loaded by
> > existing firmware already. You could even have a tool that can mangle an
> > existing bzImage's header from 64-bit to 32-bit, say using the newly
> > added kernel_info structure to record the existence and location of
> > efi32_pe_entry.
> >
> 
> That wouldn't work with, say, signed distro kernels.

No, the idea would be that the distro would distribute two signed
images, one 32-bit and one 64-bit, which are identical except for the
header. At install time, the installer chooses based on the system's
firmware bit-ness.

> 
> > Also, the PE header can live anywhere inside the image, right? Is there
> > any reason to struggle to shoehorn it into the "boot sector"?
> 
> It cannot. It must live outside a region described by the section headers.

It could still be inserted after .setup, or at the very end of the file, no?
