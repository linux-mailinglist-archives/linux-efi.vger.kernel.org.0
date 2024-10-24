Return-Path: <linux-efi+bounces-2016-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D64759AF31B
	for <lists+linux-efi@lfdr.de>; Thu, 24 Oct 2024 21:57:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DD1F1F210D7
	for <lists+linux-efi@lfdr.de>; Thu, 24 Oct 2024 19:57:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1AD31FF5FD;
	Thu, 24 Oct 2024 19:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e73TzK2G"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B6DF1A3A95;
	Thu, 24 Oct 2024 19:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729799849; cv=none; b=vAWs1uNh8Y9tJS8nGatPxxvbnW55pG7xzZQnMC6JA6ykGCSvtSdtArxMPo1DIkYuNzzpXS999nRDyeacFMWmXkfO/3hVbnek1idjiVbnpepiRNvWxNT9FhIQmC3UG3zbic0P9QFqx0XoHNvT30GmnasrtXGxwUzqrUExpT7F5gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729799849; c=relaxed/simple;
	bh=gOn6T3lWiKaxNxhYs41benmtcEZIjMyZ2IUbcXX00nQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hvv6hB8mVqsQkO9fwkBuHR34+/AaK7geDjHa9VnOcPRp0RnPDUEoyPUqVWGrYK+uIX1RHZObO8V5QzhBT56Yt1kBS0SufjCNgzeqJsUj6v8m3z2zQAqfoeDnSirX8tEP0b5IifLJB0rDTzw6cISrh0E4YpcJ5aIRk/NSZ7tyIFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e73TzK2G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70463C4CECD;
	Thu, 24 Oct 2024 19:57:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729799849;
	bh=gOn6T3lWiKaxNxhYs41benmtcEZIjMyZ2IUbcXX00nQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e73TzK2Ggyd8lQr/wIg+tIKHA6B0skKLKEHIMU8ouylH6mW7IuUzfXXIOWLBo1LtH
	 aZ7xD3r9GE+1dfWskbtU3wnTf1xOeLYUzB42pZfj0VwVD92Xau6aTiOcF59fbrYrrh
	 fbf9nOUcuvWTE/PuF7PEK3tiSwPXCVfmF7Lsxa4GYUkuNer/bsR5uscEynYECo65hF
	 Oxew16yGZ6ewIRda75moxkaGp8okhOJY5AgD2iazYmQoycx8fBg2VUJ315Vj7p9mWX
	 AiKWgjeXZbIrVs96YDAvjGoWiuSvt4f0tT99053Nljxj+pQ9daw9zgtzrkbWqyKzIN
	 YczXwSBMBsU7w==
Date: Thu, 24 Oct 2024 19:57:21 +0000
From: sergeh@kernel.org
To: Eric Snowberg <eric.snowberg@oracle.com>
Cc: "open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>,
	David Howells <dhowells@redhat.com>,
	David Woodhouse <dwmw2@infradead.org>,
	"herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
	"davem@davemloft.net" <davem@davemloft.net>,
	Ard Biesheuvel <ardb@kernel.org>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
	=?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
	"casey@schaufler-ca.com" <casey@schaufler-ca.com>,
	Stefan Berger <stefanb@linux.ibm.com>,
	"ebiggers@kernel.org" <ebiggers@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	open list <linux-kernel@vger.kernel.org>,
	"keyrings@vger.kernel.org" <keyrings@vger.kernel.org>,
	"linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
	"linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
	"linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>
Subject: Re: [RFC PATCH v3 08/13] clavis: Introduce new LSM called clavis
Message-ID: <ZxqmoV-izscjbovh@lei>
References: <20241017155516.2582369-1-eric.snowberg@oracle.com>
 <20241017155516.2582369-9-eric.snowberg@oracle.com>
 <ZxhetCy5RE1k4_Jk@lei>
 <F911D28D-F8EC-4773-8143-2B4E207DA202@oracle.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <F911D28D-F8EC-4773-8143-2B4E207DA202@oracle.com>

On Wed, Oct 23, 2024 at 07:25:21PM +0000, Eric Snowberg wrote:
> > On Oct 22, 2024, at 8:25 PM, sergeh@kernel.org wrote:
> > 
> > On Thu, Oct 17, 2024 at 09:55:11AM -0600, Eric Snowberg wrote:
> >> 
> >> +The Clavis LSM contains a system keyring call .clavis.  It contains a single
> > 
> > s/call/called/
> 
> I will change that, thanks.
> 
> >> +asymmetric key that is used to validate anything added to it.  This key can
> >> +be added during boot and must be a preexisting system kernel key.  If the
> >> +``clavis=`` boot parameter is not used, any asymmetric key the user owns
> > 
> > Who is "the user", and precisely what does "owns' mean here?  Is it just
> > restating that it must be a key already in one of the builtin or secondary
> > or platform keyrings?
> 
> In the case where Clavis was not provided a key id during boot, root can 
> add a single public key to the .clavis keyring anytime afterwards.  This 
> key does not need to be in any of the system keyrings.  Once the key is 
> added, the Clavis LSM is enabled. The root user must also own the private 
> key, since this is required to do the ACL signing. I will try to clarify this better 

Ooh, I see.  Own it as in be able to sign things with it.  Of course.  Thanks.

> in the documentation. 
> 
> I wouldn't expect this to be the typical way Clavis would be used. I would 

Right, I wasn't asking because I would want to use it that way, but
because it feels potentially dangerous :)

> also be interested in any feedback if enabling the Clavis LSM this way 
> following boot should be removed.  If this were removed, Clavis could 
> only be enabled when using the boot parameter.

Yeah I don't know enough to give good guidance here.  I do worry about
UKIs enforcing only the built-in signed kernel command line and so preventing
a user from appending their own clavis= entry.  Not knowing how this
will end up getting deployed, I'm not sure which is the more important
issue.

> > And this is done by simply loading it into the clavis keyring, right?
> 
> Correct.
> 

