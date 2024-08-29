Return-Path: <linux-efi+bounces-1623-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 448909646B5
	for <lists+linux-efi@lfdr.de>; Thu, 29 Aug 2024 15:34:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B978C1F21FF7
	for <lists+linux-efi@lfdr.de>; Thu, 29 Aug 2024 13:34:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 881981B1427;
	Thu, 29 Aug 2024 13:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GWUmH+VD"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 583F31B1407;
	Thu, 29 Aug 2024 13:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724938141; cv=none; b=Qfnu1f/xEywTrS5UwDNABNwvBJSfpK2d9t/qxQlMBF0i8fRfcI1JhYqirLSdwp9LSiIJS5VqqcmPdMjyECtmshumDM+0SoupdC1HYICAQVWuaRjeXwyUZFdKZ1fCF/fNVV0SPLjVckkBsNGfLEbTg2j1GNZFEhzcqkG82tQQkGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724938141; c=relaxed/simple;
	bh=/JM47t330311w1URWNgJKWeR3KsLsi57yIqe7LWcBDQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nR4Lqm1EQKfUWBczgSHL/lqaZze/KlVa+oAMVsFlqDbIIzMT0WVvUQoXhVHRti0234v0qVp+J8I+J1n+p4nfxTJQRMnvjFgs3CjiNS+x7ZGVtjwueSO1z45jxAtbWnp5Xhb9hBJeqBhMk0W/3UUL8NGmd0o3yCMpIhYDCh5QMiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GWUmH+VD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38C65C4CEC5;
	Thu, 29 Aug 2024 13:29:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724938141;
	bh=/JM47t330311w1URWNgJKWeR3KsLsi57yIqe7LWcBDQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=GWUmH+VDn7PGqf7OCkWt61y26BuOc3jvCOyW80wPk0Ea2oPNCiKqWh1ZzJXv2Ycpm
	 d1z9q70phGGVVwWFmlVTPx43K+W1FXEuXO08ofStOQh8+8e5gwvR+o8WHBPEHD1Nmq
	 9b1Krr82ZBHWHYH115jZ3ZYVifjgZmjZvstLzZIzQigeybQLkBs3s+WuWK6DN2MRfV
	 TqvT7Cxc9LzX4rpzAGWe8DIH6JIyG4v26B4oEirVDm1dDj6NU4A67skJ8Pa8yX45X1
	 NFfhPhhzPr7eY/1oHrx3CjjtLwSz2EZfRhsxrrbO37iHQ5ARxzE79CGDoAv/4dboNm
	 e8coKFIvcg1+Q==
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2f50966c469so7353051fa.3;
        Thu, 29 Aug 2024 06:29:01 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUh2rQ5UcLWKTQqGHJpILli51G97PRj5XuAYwc23H6/1JBQY6SLXgag6CW6ZWG5Q+HHU8o7NaLONxIEui3VW5J4@vger.kernel.org, AJvYcCVRGmywkKjoxh38UGzw1OEBnZnsI4WAmlR3lIseGDeV8p8xhQfoUKXhYN4M/fW7OZ+67tPCJV3EL6ov@vger.kernel.org, AJvYcCWqwiscKjDzLOvEmGxW7o7VYw5O4VllfrTCXzdaCOnwyId0LWeyvs/Wjvfmvmt4RjlWeMbzOVdk8OuVf+o=@vger.kernel.org, AJvYcCXOVScWQ7IkRjdQg6FwpPcBA4NSQP3VPELULjVDfcI+q5zXDeRfzVNUuofgx2lROmvVeukApizl0/Y0@vger.kernel.org, AJvYcCXqrcNQ+3Tf589RTl9cauGDiQ9KEujnHCEncxcGmot5h72lpgU7Ld4aL6TB7/TxSiMss9ABW0/QP0nbcXXX@vger.kernel.org
X-Gm-Message-State: AOJu0YzLnJ5r0dpd+Ulj9i9Zxu9O7wSVF3rhRrcDq1IR2FsaSnrHsprx
	UZWSDKN8CPTr5XvttA9ZuxyCnhEZZZv8hRVSSUIRrdfttLjW9D20LrYoVgc2+K392StU91OMAtt
	VvbzR0zSyAXqlbTjgi0PJeGmKB/4=
X-Google-Smtp-Source: AGHT+IG7brDpiVxJl+LLeO4JEGrNvWC9+/qw29ZvVDhohPvAunRSDVjoDP7LpczQ2+SS7Lyf3hGLblkJdiXuBsb3zXM=
X-Received: by 2002:a05:6512:340c:b0:52e:9382:a36 with SMTP id
 2adb3069b0e04-5353e57cb27mr1967760e87.30.1724938139518; Thu, 29 Aug 2024
 06:28:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240826223835.3928819-21-ross.philipson@oracle.com>
 <202408290030.FEbUhHbr-lkp@intel.com> <CAMj1kXGVn85ht_srwhYXDnKffPFX=B2+Cnv-8EAocwoHi__OoQ@mail.gmail.com>
 <6b214ad2-d448-4f5f-85e9-93cd38e0e035@oracle.com> <ZtB2bP1Mx3zTr9e5@earth.li>
In-Reply-To: <ZtB2bP1Mx3zTr9e5@earth.li>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Thu, 29 Aug 2024 15:28:47 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHvTjC1ALgHnu-_Tad4Ur9RqJR_d9h8bQDvXcx2p5H2AA@mail.gmail.com>
Message-ID: <CAMj1kXHvTjC1ALgHnu-_Tad4Ur9RqJR_d9h8bQDvXcx2p5H2AA@mail.gmail.com>
Subject: Re: [PATCH v10 20/20] x86/efi: EFI stub DRTM launch support for
 Secure Launch
To: Jonathan McDowell <noodles@earth.li>
Cc: ross.philipson@oracle.com, kernel test robot <lkp@intel.com>, linux-kernel@vger.kernel.org, 
	x86@kernel.org, linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-crypto@vger.kernel.org, kexec@lists.infradead.org, 
	linux-efi@vger.kernel.org, iommu@lists.linux-foundation.org, 
	oe-kbuild-all@lists.linux.dev, dpsmith@apertussolutions.com, 
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com, 
	dave.hansen@linux.intel.com, mjg59@srcf.ucam.org, 
	James.Bottomley@hansenpartnership.com, peterhuewe@gmx.de, jarkko@kernel.org, 
	jgg@ziepe.ca, luto@amacapital.net, nivedita@alum.mit.edu, 
	herbert@gondor.apana.org.au, davem@davemloft.net, corbet@lwn.net, 
	ebiederm@xmission.com, dwmw2@infradead.org, baolu.lu@linux.intel.com, 
	kanth.ghatraju@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 29 Aug 2024 at 15:24, Jonathan McDowell <noodles@earth.li> wrote:
>
> On Wed, Aug 28, 2024 at 01:19:16PM -0700, ross.philipson@oracle.com wrote=
:
> > On 8/28/24 10:14 AM, Ard Biesheuvel wrote:
> > > On Wed, 28 Aug 2024 at 19:09, kernel test robot <lkp@intel.com> wrote=
:
> > > >
> > > > Hi Ross,
> > > >
> > > > kernel test robot noticed the following build warnings:
> > > >
> > > > [auto build test WARNING on tip/x86/core]
> > > > [also build test WARNING on char-misc/char-misc-testing char-misc/c=
har-misc-next char-misc/char-misc-linus herbert-cryptodev-2.6/master efi/ne=
xt linus/master v6.11-rc5]
> > > > [cannot apply to herbert-crypto-2.6/master next-20240828]
> > > > [If your patch is applied to the wrong git tree, kindly drop us a n=
ote.
> > > > And when submitting patch, we suggest to use '--base' as documented=
 in
> > > > https://urldefense.com/v3/__https://git-scm.com/docs/git-format-pat=
ch*_base_tree_information__;Iw!!ACWV5N9M2RV99hQ!KhkZK77BXRIR4F24tKkUeIlIrdq=
XtUW2vcnDV74c_5BmrQBQaQ4FqcDKKv9LB3HQUocTGkrmIxuz-LAC$ ]
> > > >
> > > > url:    https://urldefense.com/v3/__https://github.com/intel-lab-lk=
p/linux/commits/Ross-Philipson/Documentation-x86-Secure-Launch-kernel-docum=
entation/20240827-065225__;!!ACWV5N9M2RV99hQ!KhkZK77BXRIR4F24tKkUeIlIrdqXtU=
W2vcnDV74c_5BmrQBQaQ4FqcDKKv9LB3HQUocTGkrmI7Z6SQKy$
> > > > base:   tip/x86/core
> > > > patch link:    https://urldefense.com/v3/__https://lore.kernel.org/=
r/20240826223835.3928819-21-ross.philipson*40oracle.com__;JQ!!ACWV5N9M2RV99=
hQ!KhkZK77BXRIR4F24tKkUeIlIrdqXtUW2vcnDV74c_5BmrQBQaQ4FqcDKKv9LB3HQUocTGkrm=
IzWfs1XZ$
> > > > patch subject: [PATCH v10 20/20] x86/efi: EFI stub DRTM launch supp=
ort for Secure Launch
> > > > config: i386-randconfig-062-20240828 (https://urldefense.com/v3/__h=
ttps://download.01.org/0day-ci/archive/20240829/202408290030.FEbUhHbr-lkp@i=
ntel.com/config__;!!ACWV5N9M2RV99hQ!KhkZK77BXRIR4F24tKkUeIlIrdqXtUW2vcnDV74=
c_5BmrQBQaQ4FqcDKKv9LB3HQUocTGkrmIwkYG0TY$ )
> > >
> > >
> > > This is a i386 32-bit build, which makes no sense: this stuff should
> > > just declare 'depends on 64BIT'
> >
> > Our config entry already has 'depends on X86_64' which in turn depends =
on
> > 64BIT. I would think that would be enough. Do you think it needs an exp=
licit
> > 'depends on 64BIT' in our entry as well?
>
> The error is in x86-stub.c, which is pre-existing and compiled for 32
> bit as well, so you need more than a "depends" here.
>

Ugh, that means this is my fault - apologies. Replacing the #ifdef
with IS_ENABLED() makes the code visible to the 32-bit compiler, even
though the code is disregarded.

I'd still prefer IS_ENABLED(), but this would require the code in
question to live in a separate compilation unit (which depends on
CONFIG_SECURE_LAUNCH). If that is too fiddly, feel free to bring back
the #ifdef CONFIG_SECURE_LAUNCH here (and retain my R-b)

