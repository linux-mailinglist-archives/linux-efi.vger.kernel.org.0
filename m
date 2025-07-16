Return-Path: <linux-efi+bounces-4387-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6315DB0781D
	for <lists+linux-efi@lfdr.de>; Wed, 16 Jul 2025 16:31:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0FCBE7B4DC3
	for <lists+linux-efi@lfdr.de>; Wed, 16 Jul 2025 14:29:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B3B325BEE5;
	Wed, 16 Jul 2025 14:30:25 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A58792594BD;
	Wed, 16 Jul 2025 14:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752676225; cv=none; b=Y6b9Y1Tiv5n2c3db+tfgpF8Yxx7jC13WUOK5m7fFf2eEJzGvG4pedb/jh6ov1/xGQbyMAKc+0eBk/VJEscn9Q11irwBrEhh7haqJIX3sXy/TemgO4hB9mjbBwVw/7Ze8WnJUKIrfrYxvL+/Nqq0ctpdxwFOjOjTHd9kXF/fI+GU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752676225; c=relaxed/simple;
	bh=8oM9MQ66mfTzATcDVH9XtAJsNQRIzw+rxOctjC97cyI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uDsT88gvneu8XmRmULTL7AaK919K6v9TQEFaDqZqStEUBNtUNxu6fh5JabNih1Mr9jdm+XilDmVJs5Ail0hlTZnfjqzoW3c2GMI1QLu1NZyA/F6KfUXLCctjOszdHykG7jAUdotTJAZJSc679aa7ACfovQgiqkMxVuIQWcFaoo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-ae0b2ead33cso162591666b.0;
        Wed, 16 Jul 2025 07:30:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752676222; x=1753281022;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pNwVjl6m3wKgc/VnHpKTaKyRntyURP7PDtl2ZAtqmEg=;
        b=T++1qXIVZ8SQ9mfCAKCzYOCPRo8iYoau0tcwULQSimZUKbZhQGRcXFJbF8icFYwhMk
         /cykQkpbmm9YwbEPJzn8vmKc3sLeVmocCd/kUE4xmDidFg9VeKoaiUVJe7uz2k1YkXLi
         FPz/bSN0v60U5Q/wRME+wLDVY4+7GB7d1x+X/byrX445uRf8A120Z5ypfZCKY4ljvVBL
         dYFxT2BHBLHTPN5uB3e3NIy6xII43xec8p2m2N3wba88JTvwm8bGFwBeGIcllZeZw5SG
         Es5P0vYvtFrmU6f+lCn8UkFal7np8Z/OPPQcaD7MT7cz+pATyC9EHr/9CFs3Aw840toL
         SjXw==
X-Forwarded-Encrypted: i=1; AJvYcCWrNI6GPxVAATBRk2Iww2mV1l7dpIvg/dyY2WaT0r7K6yk56rgBmFxIE7r8DMKhATkINHY5G4zhLiY=@vger.kernel.org, AJvYcCX6JhfEFTFOqdVXYvUyMZdrtEmrAvoDEZcREfHLkmDv3xSRHrVzbZgtvzXlEm5cS+CXDtJOqK+8FDTMGSDF@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8aFjm95zX2Qh/INt++TjrJWq04X0KGxXOwNqmvYbbyYj12S7R
	uFq1dywbIBGjnGvbLX0d9ligiHppBTbNSW6gYzpdFQfLSNyNEv/x3It4
X-Gm-Gg: ASbGncuCAGZe8MhQ9WzlLO0O0L01PlutOS3qslCH+hEaTWpV+mAYhR7LbpQ+ne8XDXm
	mmcOtapOfDBgc4IgAUjO3IystDwc842Kwjl92IixpUjtPqAmXlYCVHti1lr1MBXuJKARTowsD7f
	A/UgL9AlfrzqFRNjR3+T0uzj0D0xt3C4GTA8yK8QDHUYZJ36v3FzSafhx/Oqus0OVl787uJzXAs
	/69u6t0CNZoQ0WRXkbIQUTEDntJVvGHFmISUplWdbbGgzkPjXlsnyYOy1YknSy7wE4hvDMKjS6q
	n4wCH5CSJZaaesSjcZx9qQpzTRSOGgbQjWou+i8+M8PbVbbLSJchURQwb/jQyQYq70lmec25IXZ
	JJkPw7gaoSAKijw==
X-Google-Smtp-Source: AGHT+IFJa0gqqYlHrTx18e5eprFlql9LapqX5HX9Q5HeZNX+xnHp/a4vEMVPx5GPqECb6siCtRN/zw==
X-Received: by 2002:a17:907:d2c1:b0:ad8:942b:1d53 with SMTP id a640c23a62f3a-ae9b5dc65b5mr712411766b.27.1752676221747;
        Wed, 16 Jul 2025 07:30:21 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff:71::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e7e910c7sm1220250266b.15.2025.07.16.07.30.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 07:30:21 -0700 (PDT)
Date: Wed, 16 Jul 2025 07:30:19 -0700
From: Breno Leitao <leitao@debian.org>
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: Ard Biesheuvel <ardb@kernel.org>, Jeremy Kerr <jk@ozlabs.org>, 
	linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH] efivarfs: Suppress false-positive kmemleak warning for
 sfi
Message-ID: <pxsmb5nsar65occgepuoetame3ia6mudmw54cx7ah7bu57utkh@b6jeupqvprjz>
References: <20250715-kmemleak_efi-v1-1-c07e68c76ae8@debian.org>
 <CAMj1kXHJpRioZD7aUJnkMLWkiTmQ_Nr6MNcSYR0adeLdjf5BrA@mail.gmail.com>
 <rvlw467lzx5yx3sl56u3xcc2hhhn3vj2fu7msg3e5o4giwtkcb@oomdafhhnqcv>
 <a3d063f4b0ccaad7595938ea0dca016872882f0d.camel@HansenPartnership.com>
 <7fe68ef138e43a5cf83c8b5d2dd3fc8101a8a225.camel@HansenPartnership.com>
 <qdw7skjlcw6dvnewpfrtxc27pm7sroan5eyn53exndehp3blav@z25oqkoo3ohw>
 <ec0a66f40bc826bd016f338568e01908b86be35a.camel@HansenPartnership.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ec0a66f40bc826bd016f338568e01908b86be35a.camel@HansenPartnership.com>

On Wed, Jul 16, 2025 at 09:26:03AM -0400, James Bottomley wrote:
> On Wed, 2025-07-16 at 06:16 -0700, Breno Leitao wrote:

> > diff --git a/fs/efivarfs/super.c b/fs/efivarfs/super.c
> > index c900d98bf4945..07a3b9293396b 100644
> > --- a/fs/efivarfs/super.c
> > +++ b/fs/efivarfs/super.c
> > @@ -390,10 +390,22 @@ static int efivarfs_reconfigure(struct
> > fs_context *fc)
> >  	return 0;
> >  }
> >  
> > +static void efivarfs_free(struct fs_context *fc)
> > +{
> > +	struct efivarfs_fs_info *sfi;
> > +
> > +	sfi = fc->s_fs_info;
> > +	if (!sfi)
> > +		return;
> 
> Here, you'll excite the coccinelle checkers looking for if(x) free(x)
> because free() already also has a test for NULL.

Good point.

> Other than that elision, it looks fine to me.

Thanks. I will send a v2.
--breno

