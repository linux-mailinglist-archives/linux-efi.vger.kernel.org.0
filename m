Return-Path: <linux-efi+bounces-6225-lists+linux-efi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-efi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QM1UAuEfoGmzfgQAu9opvQ
	(envelope-from <linux-efi+bounces-6225-lists+linux-efi=lfdr.de@vger.kernel.org>)
	for <lists+linux-efi@lfdr.de>; Thu, 26 Feb 2026 11:26:41 +0100
X-Original-To: lists+linux-efi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 707841A4353
	for <lists+linux-efi@lfdr.de>; Thu, 26 Feb 2026 11:26:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C666C30ADBAC
	for <lists+linux-efi@lfdr.de>; Thu, 26 Feb 2026 10:24:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDD173A4F47;
	Thu, 26 Feb 2026 10:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CqBSIZl/"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8F4D3A641E;
	Thu, 26 Feb 2026 10:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772101450; cv=none; b=A+6eXLo5cIpTSi9jS2e5j0sHOsGNsRYZ9Ltq694LjsYT6wlG9ZfQzXnjMbtEm93F6wqY5hr3ebz4w8AeCUvk3jLGCJZdtKR52syw2YCoe1ZG0xqgCOcnm1WuEa+Kfl4M0fCYq6c1zOQCjX2iRXWvaJ/Nkz/6SW1Ylcj7vk/c/DU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772101450; c=relaxed/simple;
	bh=P8zq4XL1vIHvWaTfBf9OJPokXFV2/Uw/qIckm/L5wQg=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=CH9kMJSuPJi/PULwhlY5FShUk4S/ddVxWVgl9C8C2YbL1RGNxZaZ4//q5hSxuuK1Vz8kbWbJfdc37Mz3tVX1P0X67Aqtv9+frFfTKbW2Y+Tg87bRuKgG5VVX/8jiof5c7RxiM4Fcy4wYjUpg7onaDmMLcdTgtQnFuIhzNuIecf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CqBSIZl/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AAECC19422;
	Thu, 26 Feb 2026 10:24:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772101450;
	bh=P8zq4XL1vIHvWaTfBf9OJPokXFV2/Uw/qIckm/L5wQg=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=CqBSIZl/P5R11a+PbbwP8EJIEnape46aReEtYeFPGKuQwo6JuYPMOhUf/ivT/NGkB
	 eXMFnYLPc0Qug2v3GAlm2hfMo3AEhaOEyi3ZyF45CWN+wmg1Ytanhv9lAvK+0xMHh2
	 fkBzkKxMEF1f73kx0BbvlVzVwD2esgJecthJePIYctOyCgv1N+vOc4FeretrL+9dwl
	 yPVn11PrBJc5BXMOfxAd+eGXEmJnTZin8RXBEGmytdYJFgR2oDdrICNNK+pUzag+LJ
	 xPKXbyJ9ovIhvsM3RRZ/6Mf5FMQVv2aEgMpd/+fp7PW1VuyAdwBpXIwS3ii8jK7yQ3
	 rJt1fkAYF2yIg==
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id DD5D3F4006A;
	Thu, 26 Feb 2026 05:24:07 -0500 (EST)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-01.internal (MEProxy); Thu, 26 Feb 2026 05:24:07 -0500
X-ME-Sender: <xms:Rx-gaXkDrx5pnznR-SNMQS1tYTFTDjDVzc2UVuufzpa3L83PXaWj2A>
    <xme:Rx-gaVoEvkp6raOOwqQWPDa0cH-Ob-gPQix5xIzkuQVQm6h-NQbdzrS1pMcsoN3Ia
    -kZBU3FrMUKRHOIg7YnLpvy204Tr5tobrq5gruzze2vMtko18K1InM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvgeehjeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedftehrugcu
    uehivghshhgvuhhvvghlfdcuoegrrhgusgeskhgvrhhnvghlrdhorhhgqeenucggtffrrg
    htthgvrhhnpeekvdffkefhgfegveekfedtieffhfelgeetiedvieffhfekfeeikeetueeg
    teetteenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomheprghrugdomhgvshhmthhprghuthhhphgv
    rhhsohhnrghlihhthidqudeijedthedttdejledqfeefvdduieegudehqdgrrhgusgeppe
    hkvghrnhgvlhdrohhrghesfihorhhkohhfrghrugdrtghomhdpnhgspghrtghpthhtohep
    feeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegsphesrghlihgvnhekrdguvg
    dprhgtphhtthhopegtrghtrghlihhnrdhmrghrihhnrghssegrrhhmrdgtohhmpdhrtghp
    thhtohepmhhpvgesvghllhgvrhhmrghnrdhiugdrrghupdhrtghpthhtohepughmihhtrh
    ihrdhkrghsrghtkhhinhesghhmrghilhdrtghomhdprhgtphhtthhopehnphhighhgihhn
    sehgmhgrihhlrdgtohhmpdhrtghpthhtohepshgvrhhgvgeshhgrlhhlhihnrdgtohhmpd
    hrtghpthhtoheprhhosggvrhhtohdrshgrshhsuheshhhurgifvghirdgtohhmpdhrtghp
    thhtoheprhhosggvrhhtohdrshgrshhsuheshhhurgifvghitghlohhuugdrtghomhdprh
    gtphhtthhopegurghvvgdrhhgrnhhsvghnsehinhhtvghlrdgtohhm
X-ME-Proxy: <xmx:Rx-gaceSkD7L3hUQ-QIntX5c8SF2UJvuNnlnCMg5x0km8JqIId1NUw>
    <xmx:Rx-gaXnaIY1-tJR3H2eKYjQqxgSwsae5h1FvMCQzz1XTnwkXn4A87w>
    <xmx:Rx-gaWo6YeaJZds-Per8yiexkNYiocIFKlSdVrZEta5R-DmtVqRepA>
    <xmx:Rx-gaU9JdnIBR33acIHa5vRJ_FAVN8423onO6PDBDHqIfNIXMgTbhw>
    <xmx:Rx-gaS0UmRYHqy-FoG7gumIna3Ay9Z737XOXqgkPGLVVt4wqDB4deV7_>
Feedback-ID: ice86485a:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id AE587700065; Thu, 26 Feb 2026 05:24:07 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A6OHCiXwHjx-
Date: Thu, 26 Feb 2026 11:23:47 +0100
From: "Ard Biesheuvel" <ardb@kernel.org>
To: "Mimi Zohar" <zohar@linux.ibm.com>
Cc: "Coiby Xu" <coxu@redhat.com>, "Dave Hansen" <dave.hansen@intel.com>,
 linux-integrity@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>,
 "Roberto Sassu" <roberto.sassu@huaweicloud.com>,
 "Catalin Marinas" <catalin.marinas@arm.com>,
 "Will Deacon" <will@kernel.org>,
 "Madhavan Srinivasan" <maddy@linux.ibm.com>,
 "Michael Ellerman" <mpe@ellerman.id.au>,
 "Nicholas Piggin" <npiggin@gmail.com>,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
 "Vasily Gorbik" <gor@linux.ibm.com>,
 "Alexander Gordeev" <agordeev@linux.ibm.com>,
 "Christian Borntraeger" <borntraeger@linux.ibm.com>,
 "Sven Schnelle" <svens@linux.ibm.com>,
 "Thomas Gleixner" <tglx@linutronix.de>, "Ingo Molnar" <mingo@redhat.com>,
 "Borislav Petkov" <bp@alien8.de>,
 "Dave Hansen" <dave.hansen@linux.intel.com>,
 "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
 "H . Peter Anvin" <hpa@zytor.com>,
 "Roberto Sassu" <roberto.sassu@huawei.com>,
 "Dmitry Kasatkin" <dmitry.kasatkin@gmail.com>,
 "Eric Snowberg" <eric.snowberg@oracle.com>,
 "Paul Moore" <paul@paul-moore.com>, "James Morris" <jmorris@namei.org>,
 "Serge E. Hallyn" <serge@hallyn.com>,
 "Jarkko Sakkinen" <jarkko@kernel.org>,
 "moderated list:ARM64 PORT (AARCH64 ARCHITECTURE)"
 <linux-arm-kernel@lists.infradead.org>,
 "open list" <linux-kernel@vger.kernel.org>,
 "open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)"
 <linuxppc-dev@lists.ozlabs.org>,
 "open list:S390 ARCHITECTURE" <linux-s390@vger.kernel.org>,
 "open list:EXTENSIBLE FIRMWARE INTERFACE (EFI)"
 <linux-efi@vger.kernel.org>,
 "open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>,
 "open list:KEYS/KEYRINGS_INTEGRITY" <keyrings@vger.kernel.org>
Message-Id: <2115ea47-9a9f-4718-8531-4a9c2067899b@app.fastmail.com>
In-Reply-To: <ad471c33eeb9e21c49ac81032dc64555a2fb816f.camel@linux.ibm.com>
References: <20260115004328.194142-1-coxu@redhat.com>
 <20260115004328.194142-2-coxu@redhat.com>
 <CAMj1kXFXNo1-pMbo-VZrjQ3TYe1tufebrLr_avL12A0nHMSGnA@mail.gmail.com>
 <8bfa859ed3a4f1cf0db0ab64d8c1c3b24684582a.camel@linux.ibm.com>
 <CAMj1kXHsJNZoUEnbD1y=v4Ftuv9d2c08VckRV7ru4k4P83vZbQ@mail.gmail.com>
 <97b69bc79a5d9246f7a399510908c7b95b2e95e7.camel@linux.ibm.com>
 <CAMj1kXGx4ebaK87W7k0SNUNQnO9+=z1nmYxXC7retmp3OqRRFg@mail.gmail.com>
 <ac5e5e45c12e9b0bda19807e60b06057d74be0b3.camel@linux.ibm.com>
 <aW2i3yacr5TvWU-m@Rk>
 <1a0b6e5601a673a81f8823de0815f92b7afbeb60.camel@linux.ibm.com>
 <CAMj1kXFBMSEdRL8FotASbQO3dcfNG0bpp9Vnm5JPn-yjyDr=GA@mail.gmail.com>
 <ad471c33eeb9e21c49ac81032dc64555a2fb816f.camel@linux.ibm.com>
Subject: Re: [PATCH 1/3] integrity: Make arch_ima_get_secureboot integrity-wide
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.65 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	TAGGED_FROM(0.00)[bounces-6225-lists,linux-efi=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[36];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[redhat.com,intel.com,vger.kernel.org,linux.ibm.com,huaweicloud.com,arm.com,kernel.org,ellerman.id.au,gmail.com,linutronix.de,alien8.de,linux.intel.com,zytor.com,huawei.com,oracle.com,paul-moore.com,namei.org,hallyn.com,lists.infradead.org,lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[app.fastmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ardb@kernel.org,linux-efi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-efi];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 707841A4353
X-Rspamd-Action: no action


On Wed, 25 Feb 2026, at 01:03, Mimi Zohar wrote:
> On Wed, 2026-01-21 at 17:25 +0100, Ard Biesheuvel wrote:
>> On Wed, 21 Jan 2026 at 16:41, Mimi Zohar <zohar@linux.ibm.com> wrote:
>> > 
>> > On Mon, 2026-01-19 at 12:04 +0800, Coiby Xu wrote:
>> > 
>> > > diff --git a/security/integrity/ima/Kconfig b/security/integrity/ima/Kconfig
>> > > index 976e75f9b9ba..5dce572192d6 100644
>> > > --- a/security/integrity/ima/Kconfig
>> > > +++ b/security/integrity/ima/Kconfig
>> > > @@ -311,6 +311,7 @@ config IMA_QUEUE_EARLY_BOOT_KEYS
>> > >   config IMA_SECURE_AND_OR_TRUSTED_BOOT
>> > >          bool
>> > >          depends on IMA_ARCH_POLICY
>> > > +       depends on INTEGRITY_SECURE_BOOT
>> > > 
>> > > 
>> > > Another idea is make a tree-wide arch_get_secureboot i.e. to move
>> > > current arch_ima_get_secureboot code to arch-specific secure boot
>> > > implementation. By this way, there will no need for a new Kconfig option
>> > > INTEGRITY_SECURE_BOOT. But I'm not sure if there is any unforeseen
>> > > concern.
>> > 
>> > Originally basing IMA policy on the secure boot mode was an exception.  As long
>> > as making it public isn't an issue any longer, this sounds to me.  Ard, Dave, do
>> > you have any issues with replacing arch_ima_get_secureboot() with
>> > arch_get_secureboot()?
>> 
>> I don't see an issue with that. If there is a legitimate need to
>> determine this even if IMA is not enabled, then this makes sense.
>
> Ard, Dave -
>
> FYI, Coiby posted v3 of this patch set[1], which is queued in the next-
> integrity-testing branch[2].
>
> [1]
> https://lore.kernel.org/linux-integrity/20260213012851.2532722-1-coxu@redhat.com/
>
> [2] https://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git/
>

Ack. Looks fine to me.


