Return-Path: <linux-efi+bounces-1628-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CDDD7964CB5
	for <lists+linux-efi@lfdr.de>; Thu, 29 Aug 2024 19:26:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 58313B21E6F
	for <lists+linux-efi@lfdr.de>; Thu, 29 Aug 2024 17:26:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F6911B5ECB;
	Thu, 29 Aug 2024 17:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20230601.gappssmtp.com header.i=@amacapital-net.20230601.gappssmtp.com header.b="pNtaPKTq"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B83481B4C3F
	for <linux-efi@vger.kernel.org>; Thu, 29 Aug 2024 17:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724952395; cv=none; b=GeWkQbRdTDf5LmW5MPXjXXJKwGehdKZ3MtihGlEqUQ5DRpkbN3tCiddtVcWKnFNt7AAU7LiNqzo3Od/sY/bf5g3yKL4BVf+Yo17wlOkxKNjpFgE374pJ9ielmDTybtyejqEP78wXR7CVMMXYmYhdfDZ6lcLUZH2sbxvLCua0Uds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724952395; c=relaxed/simple;
	bh=7VZ7yYporrUw0FRjwYmX04dMNvDufXFjSmEG0/Se2ak=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rk+WO9zyoWCnK1FaU8s48FobL6viTXO7jtQvsDEqVAHVE+LCDdfJ/DlQqOJtwusZQJjRBnJjw/TGotwifh00ddxm5QnOes48DLstuC1AflyWAEGnlyB1kFQknDvN4VB1oXFhwd6jAnsIzauSx9GSB6yEWwsS5hTzXl9q8gC3+NY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net; spf=pass smtp.mailfrom=amacapital.net; dkim=pass (2048-bit key) header.d=amacapital-net.20230601.gappssmtp.com header.i=@amacapital-net.20230601.gappssmtp.com header.b=pNtaPKTq; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amacapital.net
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5c0a9ae3665so1035038a12.0
        for <linux-efi@vger.kernel.org>; Thu, 29 Aug 2024 10:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20230601.gappssmtp.com; s=20230601; t=1724952391; x=1725557191; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vOQJo2GeGUsaAWwa6mncP2Ys8KGeup0MpOwdKy9vZ2s=;
        b=pNtaPKTq8z+phRW+uQGnTs+qMXHaYIL/GcjN/x/LnQf2BjyD8p5y2H+5vEhuXKXwi8
         ftG71B9DPoNzB61KcrF9I1ei9eQf2ItqUYScWVjtjkt038PDovAf+02G3PWdbSEYV/gF
         VUGanuygqMUa0EDniUcD+RGPKCi9cK0s3HVNSVxbNZWgj1KO3N8BsdQgdPTbVaho7cbN
         uffjG8xPFXRyzvmojT5Q7GJWc9gNeBN1RpYE7Fg8701yIuOCKeoEpvBhWU5Nd1dfCpBH
         lGtzdaTkl9tdb4wY11odFxjZXazcjSkQ87QjPN7HGdpnmU6q/RhAPAweUh09vLJlr1v1
         allQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724952391; x=1725557191;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vOQJo2GeGUsaAWwa6mncP2Ys8KGeup0MpOwdKy9vZ2s=;
        b=ZhhB8CSE3XtPWLAoJ79a53DuNjH4jJQWn5HIws93oUZ3+cQD1pzKWtgoQwgjz5qRv+
         bmG3NNfWYbao2TWxnfY+9VM3Wz3xGwCdHpx+bTNPoxR2JFj3BG0ygc6hX3mJLQhM7qSk
         jUi1DwB5wV2F3dHl6zHL1q0RnNX+7cv3mZ+i2++NTNjY8Y5mjCXU8yso/hdJrcEjM8EU
         EPBiRr1Ek+R/SH7s4iLvQJoQSj+aq0/Sz4X0RfCftKQV9rfC0uPDHz7evJMPnlsGAK9j
         8/WBANlsPOZjzeOcQ+YkbqKrK4p4IPEQwhQhQLUQSqVcNgh0fjpMGMQuI+JPUPo+AB9q
         Or3w==
X-Forwarded-Encrypted: i=1; AJvYcCX0n28j8g3epWI1l75jwVRox4nEJf8kF4thGB6CHZgkgx2g25xAbVfTubtnrxGaoOrNoAyVvg97Irg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuP8oweahBesfNmWrvoGy7HDfb3cF7YkEX0nAUv2hVvXuIi8TP
	q2EoR55nTtGuQoaxAyhRhHx0mIL23USFUmZAToM4TsBs/i/FARgDkPC4/UFroM1QjksWMsbQIrD
	ChGz7KDBTUvThSHieOKykXOv7o7Jj5X5upeG+
X-Google-Smtp-Source: AGHT+IH4iuyCchMQAlPW+yMmxvPWO1Nlc/xUYnfiyGoA+O59EpUNxRiKYElkWTnQ0OSm9kXEGTyn1XnDACEEoQtNqZ8=
X-Received: by 2002:a05:6402:401e:b0:5be:ff22:8eef with SMTP id
 4fb4d7f45d1cf-5c21ed98f9fmr3609188a12.36.1724952390717; Thu, 29 Aug 2024
 10:26:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240531010331.134441-1-ross.philipson@oracle.com>
 <20240531010331.134441-7-ross.philipson@oracle.com> <20240531021656.GA1502@sol.localdomain>
 <874jaegk8i.fsf@email.froward.int.ebiederm.org> <5b1ce8d3-516d-4dfd-a976-38e5cee1ef4e@apertussolutions.com>
 <87ttflli09.ffs@tglx> <CALCETrXQ7rChWLDqTG0+KY7rsfajSPguMnHO1G4VJi_mgwN9Zw@mail.gmail.com>
 <Zs/qJsKu3StL3Wzt@srcf.ucam.org>
In-Reply-To: <Zs/qJsKu3StL3Wzt@srcf.ucam.org>
From: Andy Lutomirski <luto@amacapital.net>
Date: Thu, 29 Aug 2024 10:26:18 -0700
Message-ID: <CALCETrW8jfkvMc2rwCoyiVON25YFVQZWrb4ZFFoUs3zhRV4YEQ@mail.gmail.com>
Subject: Re: [PATCH v9 06/19] x86: Add early SHA-1 support for Secure Launch
 early measurements
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, "Daniel P. Smith" <dpsmith@apertussolutions.com>, 
	"Eric W. Biederman" <ebiederm@xmission.com>, Eric Biggers <ebiggers@kernel.org>, 
	Ross Philipson <ross.philipson@oracle.com>, linux-kernel@vger.kernel.org, x86@kernel.org, 
	linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-crypto@vger.kernel.org, kexec@lists.infradead.org, 
	linux-efi@vger.kernel.org, iommu@lists.linux-foundation.org, mingo@redhat.com, 
	bp@alien8.de, hpa@zytor.com, dave.hansen@linux.intel.com, ardb@kernel.org, 
	James.Bottomley@hansenpartnership.com, peterhuewe@gmx.de, jarkko@kernel.org, 
	jgg@ziepe.ca, nivedita@alum.mit.edu, herbert@gondor.apana.org.au, 
	davem@davemloft.net, corbet@lwn.net, dwmw2@infradead.org, 
	baolu.lu@linux.intel.com, kanth.ghatraju@oracle.com, 
	andrew.cooper3@citrix.com, trenchboot-devel@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 28, 2024 at 8:25=E2=80=AFPM Matthew Garrett <mjg59@srcf.ucam.or=
g> wrote:
>
> On Wed, Aug 28, 2024 at 08:17:05PM -0700, Andy Lutomirski wrote:
>
> > Ross et al, can you confirm that your code actually, at least by
> > default and with a monstrous warning to anyone who tries to change the
> > default, caps SHA1 PCRs if SHA256 is available?  And then can we maybe
> > all stop hassling the people trying to develop this series about the
> > fact that they're doing their best with the obnoxious system that the
> > TPM designers gave them?
>
> Presumably this would be dependent upon non-SHA1 banks being enabled?

Of course.  It's also not immediately obvious to me what layer of the
stack should be responsible for capping SHA1 PCRs.  Should it be the
kernel?  Userspace?

It seems like a whole lot of people, for better or for worse, want to
minimize the amount of code that even knows how to compute SHA1
hashes.  I'm not personally convinced I agree with this strategy, but
it is what it is.  And maybe people would be happier if the default
behavior of the kernel is to notice that SHA256 is available and then
cap SHA1 before even asking user code's permission.

--Andy

