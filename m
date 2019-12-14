Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7AC9611F3B8
	for <lists+linux-efi@lfdr.de>; Sat, 14 Dec 2019 20:49:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726541AbfLNTtj (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 14 Dec 2019 14:49:39 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:39350 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726484AbfLNTtj (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 14 Dec 2019 14:49:39 -0500
Received: by mail-qk1-f193.google.com with SMTP id c16so2106462qko.6;
        Sat, 14 Dec 2019 11:49:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=EiEOyIeEYvLm23BDpqDgm3buXGZnOEEPsvT4cTrvLn0=;
        b=tcACFTjnrwnAGKiV2jbSZeT9tZqbWzhCFnfX7Z2iRPuu37wGDsE39kjA7QMrBM40Xi
         kKT7l7KE77Ve2diIme7a57APLM4vJgBYsG7IfiwpILPSbj2t2RsolmJ4HgFz1K4fW158
         hHDbIYpTNGudHNgkMxcq5cnOLgYGx2VvpO5Ei6OZYTiiNpmgXQGadIA66W/Bh+sUoBQs
         UGMsgaGVsEyTn+RMJnVkahZBNjD5f51kM7lNvsj8V2+fgm7euaRC99mTLAu1M4ICbXLU
         o2atIZnCvrJX6h0eWXjkSndAQEr/Ud8wdOFSzFJH9MYYn1ITelXS4Nq2qFGhDa+3sa20
         pCJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=EiEOyIeEYvLm23BDpqDgm3buXGZnOEEPsvT4cTrvLn0=;
        b=DP9p1+nkzHd9ni96NK8brbGEoHWYlkOkYar47Pbo3B6weNXeT7R3OghYJtohMsZ+Qj
         omB7pSw1vyEeTO9JJPhPrHmv0l+S8ED0HMSq5k/EiaPKA+Sbr6cw3yptQd02tzQHDCuz
         D+ybFFVdk7/kGypHxOacp9+t54w3wASv1OgXViM+/y8A+eAICZR6x4be29otNx1QQfV2
         qY0FGhcria3OxM3bmY/QBC6hpPzIoV1TkjNvh1DVnpIkSpisvV8MREqhTgX+93JNfW93
         KUxNmiverhi+Ip6h028kLSuJdl2AeeqxHxQ/MZdjMixFj1ot551qkN+adzeqMFs0Tnwd
         5/eA==
X-Gm-Message-State: APjAAAXRvMTiPJjKVLsCcIwhs0dAnPLNjBvcc/jyXHq/+7nbitTOfyVc
        eyk2QsiYBLoBoBo8t844qA/yUG5HQfM=
X-Google-Smtp-Source: APXvYqy5b27YZdHKBohmD2QsYsXKcqT4BHtx0ZZkHy8ami75MC5QOqmdptWTvtu+mRQV5wFv5FRgvg==
X-Received: by 2002:a37:4841:: with SMTP id v62mr18737521qka.444.1576352978391;
        Sat, 14 Dec 2019 11:49:38 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id 24sm4224597qka.32.2019.12.14.11.49.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Dec 2019 11:49:38 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Sat, 14 Dec 2019 14:49:36 -0500
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org,
        linux-efi@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
        Matthew Garrett <matthewgarrett@google.com>,
        Ingo Molnar <mingo@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 05/10] efi/libstub: distinguish between native/mixed not
 32/64 bit
Message-ID: <20191214194936.GB140998@rani.riverdale.lan>
References: <20191214175735.22518-1-ardb@kernel.org>
 <20191214175735.22518-6-ardb@kernel.org>
 <20191214194626.GA140998@rani.riverdale.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191214194626.GA140998@rani.riverdale.lan>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sat, Dec 14, 2019 at 02:46:27PM -0500, Arvind Sankar wrote:
> On Sat, Dec 14, 2019 at 06:57:30PM +0100, Ard Biesheuvel wrote:
> > +
> > +#define efi_table_attr(table, attr, instance) ({			\
> > +	__typeof__(((table##_t *)0)->attr) __ret;			\
> > +	if (efi_is_native()) {						\
> > +		__ret = ((table##_t *)instance)->attr;			\
> > +	} else {							\
> > +		__typeof__(((table##_32_t *)0)->attr) at;		\
> > +		at = (((table##_32_t *)(unsigned long)instance)->attr);	\
> > +		__ret = (__typeof__(__ret))(unsigned long)at;		\
> > +	}								\
> > +	__ret;								\
> > +})
> 
> The casting of `at' is appropriate if the attr is a pointer type which
> needs to be zero-extended to 64-bit, but for other fields it is
> unnecessary at best and possibly dangerous.  There are probably no
> instances currently where it is called for a non-pointer field, but is
> it possible to detect if the type is pointer and avoid the cast if not?

To clarify, I mean the casting via `unsigned long' -- casting to type of
__ret should be ok. We could also use uintptr_t for cleanliness when the
cast is required?
