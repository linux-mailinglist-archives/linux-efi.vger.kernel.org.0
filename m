Return-Path: <linux-efi+bounces-4846-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7C2EB599BB
	for <lists+linux-efi@lfdr.de>; Tue, 16 Sep 2025 16:26:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C5F127A78BD
	for <lists+linux-efi@lfdr.de>; Tue, 16 Sep 2025 14:24:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33A4A21C179;
	Tue, 16 Sep 2025 14:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i5qR3kuQ"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2BD418BBB9
	for <linux-efi@vger.kernel.org>; Tue, 16 Sep 2025 14:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758032770; cv=none; b=medzvwgXYRMpWCi2LtkCL5twhcUSC/IMCTKuGkyD0D4QseBawb+1CEEJAMPbSWs9hxdfTJ5VWTMgyBw5mptMS0XwD/+im/OoR+RvsPHEHrzApC3c23jsAaZ+ytFL0GcIAmAWaCacLQQLMPrNTK1K+lCJip7PyFN4pca2gvahbMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758032770; c=relaxed/simple;
	bh=uMcNijcnMhNAb21qUVKzkgNAFVxzUGHz23fC60dNeIw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DCHqzvQQ0CCbElK3c9AxhmC5Lg+qPuVrQ0R8y/lrgMXxzNjI8kqLJFmtAvcm7/mClVwCTa9qM5eVBIAaS26qN/830fc8yH9S4XKlmzcMDucdzU6mfLDM8gY+vk4Ia1C9JqoAaxxZUG04bp7X357tv0UvRJVU0DfZngJZNyeOPFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i5qR3kuQ; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-77616dce48cso3057248b3a.0
        for <linux-efi@vger.kernel.org>; Tue, 16 Sep 2025 07:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758032768; x=1758637568; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uMcNijcnMhNAb21qUVKzkgNAFVxzUGHz23fC60dNeIw=;
        b=i5qR3kuQul7ReRtJ1G689EkiiLGo4VjWuui5IT8xFrpYrkc6PTtOIk0m4yzjYJojCj
         je0uJOYIKVPyOsOToWRO0SnwhV+nDJo+EolO0Pfwc7TkUAskgpQ4MS0IJSQFfsWBonW+
         lcfeSHFOaZW+DzSDbvb94tXc+GF6t6pnzwvwWApUYDiCCT/zTvrE4alKa6FKDgml63BL
         StXy9hvUlJRrOPlg8KMZec5BPca6SRcNCBc7SMjrG8EZA7vsYzIpIUiNw8rkieCcri16
         T4Hb/YjYnOcRCnueAmAdXTixYVmDKQekNAvapwQiEFL2HZE3p+1HgfTZ/FKggc/wSx+Z
         eDqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758032768; x=1758637568;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uMcNijcnMhNAb21qUVKzkgNAFVxzUGHz23fC60dNeIw=;
        b=bI+wL+KHjZkLJJ6AzJK5dqj+4D9Aqgm3WHJ5J1g7xfWRpBW+VJjgvQXCp9R6pfHb1t
         ftgVOmIASp6+5s2SzbN9m0UxE1vTD+6WpRi0clJeD3yl1OmUMF+ASm+l1nYr7pyG0oMF
         91/ZTWSDr4fWB21WeDb8ieScvcfg0xss64QRcj3GbVUnMFqmrBCfEKUqZNfLthz3EcOM
         M0/Drx7z3TYwwSjDtzd+cy6OJzSZLsgF6R4SJ6iuo5l2tYB4+pM3x6k5ZRFSh61tcwnb
         92glBN4RCT5ivQQiYxmZI+EDDHkhuqgCkzUDOd7VZqEFdnzWmSpjTwPbyDBmQBqMI72Y
         +bnw==
X-Forwarded-Encrypted: i=1; AJvYcCUXMOfe8sdnO6K+PD/d/0bQv4W6rXnLh/ezOt+iIwmq+WN0REhYHZtWe8rNHwxa275kWV9E2ZTJpCI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7U59HnnNkgc9UpIxyXQkRTfoDZrEf9ylcS+2oCwY6wvAQOfCa
	6sFlabkjZtDEp11ozu66hqKWRCJSDuDa2X7Q0I4W4suzYMwZxMeORIFj
X-Gm-Gg: ASbGnctr0wzUWVPHKDP8U17X1W0rjTjcrkNy0S3/L9bB1KuBNBZKEK6ToRJLAqmlhpc
	sQ42mxIj7n0Dq3QVYLcT3LX1FZCANd/Om9lKF6zoHiDpUEMtpZBec+xaKoI7PczPkuFuOtYJYRX
	xtiK4ApVvxY1KfbibQHscMerHb6PgNtQvnBjElJffx1zuKC9z/p466f6Ig1f/0HEvkxhjZxMCtQ
	p6zW8sm0LGHIvUzwM08lw6SMQcJtmjnTKz+n8RPbgzyzH5ec7AXEXCTIt05FgHyoFBrnrIu67Df
	yC+wpAF/uA1AUEVD12t4CXVW/hgSgOs4qvNkt61hNbrVcgiq5sTaccs7yLeQejv8YMhc/7nyoSz
	8XsN2uKbyClxRHWhT/jCWTN04k6/kM5R0cj5/
X-Google-Smtp-Source: AGHT+IGvai1R9UV5qW0JLRvwDFGRIhjqqVqH1mBx2L0LjYmLE/VS4NAz9iq4LkE/Qr5K0/uaq6wsQw==
X-Received: by 2002:a05:6a20:1590:b0:263:52cb:bc49 with SMTP id adf61e73a8af0-26352cbbd14mr11711099637.35.1758032767863;
        Tue, 16 Sep 2025 07:26:07 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b54ac02de2bsm12128980a12.17.2025.09.16.07.26.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 07:26:06 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 9679A41F4135; Tue, 16 Sep 2025 21:26:03 +0700 (WIB)
Date: Tue, 16 Sep 2025 21:26:03 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Jonathan Corbet <corbet@lwn.net>,
	Hugo Osvaldo Barrera <hugo@whynothugo.nl>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux EFI <linux-efi@vger.kernel.org>
Cc: Ard Biesheuvel <ardb@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v2] Documentation/x86: explain LINUX_EFI_INITRD_MEDIA_GUID
Message-ID: <aMlzeyu5Apwfp-1j@archie.me>
References: <20250916073244.590483-1-bagasdotme@gmail.com>
 <b629ff7e-a223-467f-8e32-78f825bd31ac@app.fastmail.com>
 <87zfaufrcq.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="pXurbY7g+wD8W3os"
Content-Disposition: inline
In-Reply-To: <87zfaufrcq.fsf@trenco.lwn.net>


--pXurbY7g+wD8W3os
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 16, 2025 at 07:40:21AM -0600, Jonathan Corbet wrote:
> "Hugo Osvaldo Barrera" <hugo@whynothugo.nl> writes:
>=20
> >> +When compiled with ``CONFIG_EFI_STUB=3Dy``, the kernel can be execute=
d=20
> >> as a
> >> +regular PE/COFF binary. See Documentation/admin-guide/efi-stub.rst for
> >> +implementation details.
> >
> > I must insist that it's a terrible idea to replace an actual link with =
the
> > name of the source file.
> >
> > This might be (marginally) more convenient for somebody who's editing t=
he
> > documentation, but it becomes completely useless for somebody who's REA=
DING
> > the documentation. Documentation needs to target readers.
> >
> > For someone reading https://www.kernel.org/doc/html/latest/arch/x86/boo=
t.html,
> > the above filename conveys no useful information.
>=20
> When the documentation is rendered into HTML, that file reference will
> be turned into a link automatically, and people reading it on kernel.org
> will not notice the difference.

That's why I keep the file cross-reference...

--=20
An old man doll... just what I always wanted! - Clara

--pXurbY7g+wD8W3os
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCaMlzdgAKCRD2uYlJVVFO
o+8YAQCQPDGTVdHgN6kNhi8fzWdgDD87slM6RKRQ2aBrU7sBWgD/arfkPpsyhNCy
ne5Fs6gwrSn7y2ClBkaa/KtkpD7cGQs=
=bvi7
-----END PGP SIGNATURE-----

--pXurbY7g+wD8W3os--

