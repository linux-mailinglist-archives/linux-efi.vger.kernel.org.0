Return-Path: <linux-efi+bounces-2009-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 35A329A442C
	for <lists+linux-efi@lfdr.de>; Fri, 18 Oct 2024 18:55:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1369A1C21164
	for <lists+linux-efi@lfdr.de>; Fri, 18 Oct 2024 16:55:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93EF12038A1;
	Fri, 18 Oct 2024 16:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=benboeckel.net header.i=@benboeckel.net header.b="k/kK18yl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ozye+AsI"
X-Original-To: linux-efi@vger.kernel.org
Received: from flow-a6-smtp.messagingengine.com (flow-a6-smtp.messagingengine.com [103.168.172.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90C99200C87;
	Fri, 18 Oct 2024 16:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729270511; cv=none; b=KOD2mmAs51MLCHjZ2s3cGONdSVm3IowyGOJvn63bTS0ElyicEOYL+x8mdW1AkeICBRQZ2sCP+K4zNZLbFKH2Zk9Risip5f0dnKBEzYSrFhA72EXVMvUk4vmYiHsh32D6+kzRXySFt68tyncrCcoNsugcHEI27/haph2tpOfIgV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729270511; c=relaxed/simple;
	bh=2BAp/Ks9vk62NXFUJKf9rtVKUHh7s1trWs775ygWLOI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CuRGR0ATYln4IRK+3JiNesV1NjzgrSZ/EpwxaEIT8Nv4YZ3A6imye0d4qy4v1ku30vfMR9LWUs54+lIwZDrMftrsHn8P7Z8LWLBx/X58SxI2oppUcN1T6roUtxxxd1FE41nJ0bzcozBJXI0U8sn26ohyc2R4nIcr9azcZXr770s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=benboeckel.net; spf=pass smtp.mailfrom=benboeckel.net; dkim=pass (2048-bit key) header.d=benboeckel.net header.i=@benboeckel.net header.b=k/kK18yl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ozye+AsI; arc=none smtp.client-ip=103.168.172.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=benboeckel.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=benboeckel.net
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailflow.phl.internal (Postfix) with ESMTP id 7B4D72006A2;
	Fri, 18 Oct 2024 12:55:07 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Fri, 18 Oct 2024 12:55:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=benboeckel.net;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm1;
	 t=1729270507; x=1729277707; bh=0L7B7yGnuyRElZHs/IM6086Uc6KmNfJm
	/hpOxLBT+m4=; b=k/kK18ylY7URLjXojRDc9N4S7rJgXMLhvlNye6dGW6oNDx3E
	V+ra4rLZWqnNummxUWVuo36cnVAcsb2q08axEPLq71LDJ0t7XgtOOL+f9MuLYjf3
	JMB4Difrk+CrPuiPAZ8wIzUCkqnWLOHg+IcLg8gmv2f/NO5xHrBHQxVzYxCcJilZ
	mLYcFti7O9pMSwxYT03AQ72CnTTeC/yx4sC+qtJDewaf7bEV9Xlhp702u94ZQi4L
	3tfQ8HleHBoBmOJGdH0uA7ze2SJZkuqCepcNIj8rpdRMIicWA0hqRNh9s6jfpz/G
	zFYyz6eFAS3PG1C5x0ZGZbJFykxb8N9lTkXKLg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1729270507; x=
	1729277707; bh=0L7B7yGnuyRElZHs/IM6086Uc6KmNfJm/hpOxLBT+m4=; b=O
	zye+AsIQf4jOgI2Lrrpu/tMoSW8fz2A51yo4ahp0ZBJGIvXjwp+vOkEu80Ni3wOB
	hFv9No6bvbWBC2GA8UVx9SHY/mJLu+E5jZ5/iVUVCYL7+H5SoWZ16um5OsIplceU
	XYfkI5EKXdnuxvKkTt4KObmHeFgogkB/Q8DULO9qqRV2sxwOMFvdTb3mjfFugyzI
	aPZz0sOPWt3PB4396k6F0NcnZr79VutMLODwSRkRcafo8GMEnq9FQZHeK3jqWEs6
	uV0Nhbi3IoFFBwgJlw3DTkG6s4AKF0EMccSCA6kRk6N/X0Z2zRsvnDqzNqvGolKI
	jucxNUCF8G2dICMKnp88A==
X-ME-Sender: <xms:6JISZ434ZPIdiHbuWYeaNcSqzVunzn9uwUZW6OtXjfW9dqoTF2Q0Tw>
    <xme:6JISZzGePpzTvvZ4vFRXLM6wgbpJq3DsseJnyI43bL1-vYOUSX4UIh6aVMHXzdMy-
    50pHNOM0p8E1mRPGgs>
X-ME-Received: <xmr:6JISZw65VRONaSByRxBIL9BfylVtic9_zpXo3O7BKnP-6_dq6KrtDAOQlDUav0jo_bd6xqobLqqs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdehfedguddtgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtugfgjggfsehtkeertddt
    reejnecuhfhrohhmpeeuvghnuceuohgvtghkvghluceomhgvsegsvghnsghovggtkhgvlh
    drnhgvtheqnecuggftrfgrthhtvghrnhepudekvdejteeuudffveffhfelfefgjeehffef
    hffhgeeiieduveehfeejffetveefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepmhgvsegsvghnsghovggtkhgvlhdrnhgvthdpnhgspghrtghp
    thhtohepvdegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegvrhhitgdrshhnoh
    ifsggvrhhgsehorhgrtghlvgdrtghomhdprhgtphhtthhopehlihhnuhigqdhsvggtuhhr
    ihhthidqmhhoughulhgvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepug
    hhohifvghllhhssehrvgguhhgrthdrtghomhdprhgtphhtthhopegufihmfidvsehinhhf
    rhgruggvrggurdhorhhgpdhrtghpthhtohephhgvrhgsvghrthesghhonhguohhrrdgrph
    grnhgrrdhorhhgrdgruhdprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhn
    vghtpdhrtghpthhtoheprghruggssehkvghrnhgvlhdrohhrghdprhgtphhtthhopehjrg
    hrkhhkoheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgruhhlsehprghulhdqmhho
    ohhrvgdrtghomh
X-ME-Proxy: <xmx:6JISZx3LjUHM3aerHTKSZK7b6NYEiKaH4KlyNHEhZDeqdpoC7cC-Bw>
    <xmx:6JISZ7FN2-4pTeiOluvybyQrliihhSJzxzgJAuyiQ5tNd8m8sg3R_A>
    <xmx:6JISZ6-2P1lNIofzl5gJo4ci2r7xVPsZe2YmP6wVKj2PJdKrxxMp0Q>
    <xmx:6JISZwmUM9wuk4eJkrqMCnfeiiCO03a_FeJiMBgfgUNX8Tmq6W2z1g>
    <xmx:65ISZzNrDCcw7YGvFpM0DJqQP45rg1wOFv3qdff4aVAW53CXXzEXMk-5>
Feedback-ID: iffc1478b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 18 Oct 2024 12:55:04 -0400 (EDT)
Date: Fri, 18 Oct 2024 12:55:03 -0400
From: Ben Boeckel <me@benboeckel.net>
To: Eric Snowberg <eric.snowberg@oracle.com>
Cc: "open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>,
	David Howells <dhowells@redhat.com>,
	David Woodhouse <dwmw2@infradead.org>,
	"herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
	"davem@davemloft.net" <davem@davemloft.net>,
	Ard Biesheuvel <ardb@kernel.org>,	Jarkko Sakkinen <jarkko@kernel.org>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,	Mimi Zohar <zohar@linux.ibm.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
	=?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
	"casey@schaufler-ca.com" <casey@schaufler-ca.com>,
	Stefan Berger <stefanb@linux.ibm.com>,
	"ebiggers@kernel.org" <ebiggers@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	open list <linux-kernel@vger.kernel.org>,
	"keyrings@vger.kernel.org" <keyrings@vger.kernel.org>,
	"linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
	"linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
	"linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>
Subject: Re: [RFC PATCH v3 05/13] clavis: Introduce a new key type called
 clavis_key_acl
Message-ID: <ZxKS57wBfgBZ21_g@farprobe>
References: <20241017155516.2582369-1-eric.snowberg@oracle.com>
 <20241017155516.2582369-6-eric.snowberg@oracle.com>
 <ZxHwaGeDCBSp3Dzx@farprobe>
 <2F718293-72DA-4E7F-99FF-690276B94F34@oracle.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2F718293-72DA-4E7F-99FF-690276B94F34@oracle.com>
User-Agent: Mutt/2.2.12 (2023-09-09)

On Fri, Oct 18, 2024 at 15:42:15 +0000, Eric Snowberg wrote:
> > On Oct 17, 2024, at 11:21 PM, Ben Boeckel <me@benboeckel.net> wrote:
> > Can this be committed to `Documentation/` and not just the Git history
> > please?
> 
> This is documented, but it doesn't come in until the 8th patch in the series. 
> Hopefully that is not an issue.

Ah, I'll look there, thanks.

> >> + if (isspace(desc[i]))
> >> + desc[i] = 0;
> > 
> > How is setting a space to `0` *removing* it? Surely the `isxdigit` check
> > internally is going to reject this. Perhaps you meant to have two
> > indices into `desc`, one read and one write and to stall the write index
> > as long as we're reading whitespace?
> > 
> > Also, that whitespace is stripped is a userspace-relevant detail that
> > should be documented.
> 
> This was done incase the end-user has a trailing carriage return at the
> end of their ACL. I have updated the comment as follows:
> 
> +       /*
> +        * Copy the user supplied contents, if uppercase is used, convert it to
> +        * lowercase.  Also if the end of the ACL contains any whitespace, strip
> +        * it out.
> +        */

Well, this doesn't check the end for whitespace; any internal whitespace
will terminate the key:

    DEAD BEEF
        ^ becomes NUL

and results in the same thing as `DEAD` being passed.

> > 
> >> +static void key_acl_destroy(struct key *key)
> >> +{
> >> + /* It should not be possible to get here */
> >> + pr_info("destroy clavis_key_acl denied\n");
> >> +}
> >> +
> >> +static void key_acl_revoke(struct key *key)
> >> +{
> >> + /* It should not be possible to get here */
> >> + pr_info("revoke clavis_key_acl denied\n");
> >> +}
> > 
> > These keys cannot be destroyed or revoked? This seems…novel to me. What
> > if there's a timeout on the key? If such keys are immortal, timeouts
> > should also be refused?
> 
> All the system kernel keyrings work this way. But now that you bring this up, neither of
> these functions are really necessary, so I will remove them in the next round.
> 
> >> +static int key_acl_vet_description(const char *desc)
> >> +{
> >> + int i, desc_len;
> >> + s16 ktype;
> >> +
> >> + if (!desc)
> >> + goto invalid;
> >> +
> >> + desc_len = sizeof(desc);
> > 
> > This should be `strlen`, no?
> 
> I will change this to strlen

Actually, this could probably be `strnlen` using `CLAVIS_ASCII_KID_MAX +
1` just to avoid running off into la-la land when we're going to error
anyways. Or even `8` because we only actually care about "is at least 7
bytes". Worth a comment either way.

Looking forward to the next cycle.

Thanks,

--Ben

