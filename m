Return-Path: <linux-efi+bounces-6194-lists+linux-efi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-efi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uHC8C35/mGlMJQMAu9opvQ
	(envelope-from <linux-efi+bounces-6194-lists+linux-efi=lfdr.de@vger.kernel.org>)
	for <lists+linux-efi@lfdr.de>; Fri, 20 Feb 2026 16:36:30 +0100
X-Original-To: lists+linux-efi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CC0CE168F11
	for <lists+linux-efi@lfdr.de>; Fri, 20 Feb 2026 16:36:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C912C3004C47
	for <lists+linux-efi@lfdr.de>; Fri, 20 Feb 2026 15:36:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 542AE33D4FA;
	Fri, 20 Feb 2026 15:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d8j24fM/"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 303E425F7B9;
	Fri, 20 Feb 2026 15:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771601785; cv=none; b=dvupQpn2Ug1bg67/pSi/lO9C3HktS5giCp/C4baan7woix0lPWJdm2JxKPWknJgHHR8Jn7BgXo3fVs43EcMxXkf0yBJS/BsdLhkQ9rs+bjN/xvayhLrlIQdJ+fjQE/gR55RXrY9HMewAUQ92/VNqf3IPw1dg3qW1RpdV0CnS1/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771601785; c=relaxed/simple;
	bh=Ip+Ok3z4b8Mn4e2k/xxO7ygofUYVx5NJdGPJvg3Uvvo=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=pZRh+19iPeKcn1RZRAMyDTv1jGPx82l0Bqx/Qps1cdNZgjxhxd1fN0YVjCSFq8ZIS1GSKKqzFDTfsJw6ka9F3TeIsCo1XnuIcDW8fkO4yzC1bG3cY+8opTeC18khHTuHMXgeCGKRaGXxyzYU1O0CwbPwFdIudg0KRKcKb/nmrCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d8j24fM/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07B75C116C6;
	Fri, 20 Feb 2026 15:36:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771601784;
	bh=Ip+Ok3z4b8Mn4e2k/xxO7ygofUYVx5NJdGPJvg3Uvvo=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=d8j24fM/iIueOFUXQImLRiw/Nvq9i5abxog58HkgSvv3tfg3f8bPIw4TIaTL2cNsF
	 gj5E9/mdWAZ8jDtMoQbP0PsHlnKjlIaYKj+W4RmlL35pZsFnxdbTRoGlT/HDBOL1oD
	 hS9oP7F1wMw4vHb8tBOq8YsCezfJ2JQwZUjGQnK92/Q6OTmB+qs8Dhl4KVI+wJ9Ynn
	 bL7miOtFFyZc+7gtzmfTPsDwSVtXhaWtx6TIZIex4mvbDtrG809w7MJGHQP/NDckLn
	 BLhR46uTaItrkYXBa7Po6XxMGAHum954lWlXf6VMAlRckrSh48zxvKM9vVUQTwYL26
	 EkdgubbdOGCcQ==
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id DD74FF4006D;
	Fri, 20 Feb 2026 10:36:22 -0500 (EST)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-01.internal (MEProxy); Fri, 20 Feb 2026 10:36:22 -0500
X-ME-Sender: <xms:dn-YaXpKzgBI7lLLXvVnqkp9s_8LSG6eYRHb_v7Dh4I_nA74WDDqdw>
    <xme:dn-Yacclxv5BJtKZ-Qq1XI4iHx3RyLHcNXmhZ9xG5qOn3jV4EcwK33tH6kozNhz9o
    AbjnGXi1_VPLoTivYQYVCdUF9t9jfiBkqZ4d5ah8cdAmjyXu-PjMSg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvvdekkedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedftehrugcu
    uehivghshhgvuhhvvghlfdcuoegrrhgusgeskhgvrhhnvghlrdhorhhgqeenucggtffrrg
    htthgvrhhnpedvueehiedtvedtleekuddutefgffdtleetfeetveejveejieehfefhjeei
    jeefudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhguodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduieejtdehtddtjeel
    qdeffedvudeigeduhedqrghruggspeepkhgvrhhnvghlrdhorhhgseifohhrkhhofhgrrh
    gurdgtohhmpdhnsggprhgtphhtthhopeefvddpmhhouggvpehsmhhtphhouhhtpdhrtghp
    thhtohepsghpsegrlhhivghnkedruggvpdhrtghpthhtohepnhhivhgvughithgrsegrlh
    humhdrmhhithdrvgguuhdprhgtphhtthhopehluhhtohesrghmrggtrghpihhtrghlrdhn
    vghtpdhrtghpthhtohepughpshhmihhthhesrghpvghrthhushhsohhluhhtihhonhhsrd
    gtohhmpdhrtghpthhtoheprghnughrvgifrdgtohhophgvrhefsegtihhtrhhigidrtgho
    mhdprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtoh
    epphgvthgvrhhhuhgvfigvsehgmhigrdguvgdprhgtphhtthhopehhvghrsggvrhhtsehg
    ohhnughorhdrrghprghnrgdrohhrghdrrghupdhrtghpthhtohepthhrvghntghhsghooh
    htqdguvghvvghlsehgohhoghhlvghgrhhouhhpshdrtghomh
X-ME-Proxy: <xmx:dn-YaZBdaidTbvEBGfz-iUZ-mgy8GA-vuxokns0lACS79eaqin2sjQ>
    <xmx:dn-YaU4tmc_oQXzOQdSawhF3iuF8TCBCCqScSkC_zNOtmM0y7z9SfA>
    <xmx:dn-YaQlTtj_nEiNEidchtEBlqmzl0pkyLthbR5p7BnKlCdBg4gvexw>
    <xmx:dn-YaXfzUes1HVb7VveqSbLUM6qO4SVJqCj2HwTjJqow0G19GkCsMw>
    <xmx:dn-YaZ3f8bIvTNMtbs-XCNvgBOCGXlsfh9Hb0ZD3p2MiApd3SUqnKoDq>
Feedback-ID: ice86485a:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id A57F1700065; Fri, 20 Feb 2026 10:36:22 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A1ToacgRLhLF
Date: Fri, 20 Feb 2026 16:35:44 +0100
From: "Ard Biesheuvel" <ardb@kernel.org>
To: "Daniel P. Smith" <dpsmith@apertussolutions.com>,
 "Thomas Gleixner" <tglx@linutronix.de>,
 "Eric W. Biederman" <ebiederm@xmission.com>,
 "Eric Biggers" <ebiggers@kernel.org>
Cc: "Ross Philipson" <ross.philipson@oracle.com>,
 linux-kernel@vger.kernel.org, x86@kernel.org,
 linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-crypto@vger.kernel.org, kexec@lists.infradead.org,
 linux-efi@vger.kernel.org, iommu@lists.linux-foundation.org,
 "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
 "H . Peter Anvin" <hpa@zytor.com>, dave.hansen@linux.intel.com,
 "Matthew Garrett" <mjg59@srcf.ucam.org>,
 "James Bottomley" <James.Bottomley@hansenpartnership.com>, peterhuewe@gmx.de,
 "Jarkko Sakkinen" <jarkko@kernel.org>, jgg@ziepe.ca,
 "Andy Lutomirski" <luto@amacapital.net>, nivedita@alum.mit.edu,
 "Herbert Xu" <herbert@gondor.apana.org.au>, davem@davemloft.net,
 corbet@lwn.net, dwmw2@infradead.org, baolu.lu@linux.intel.com,
 kanth.ghatraju@oracle.com, "Andrew Cooper" <andrew.cooper3@citrix.com>,
 trenchboot-devel@googlegroups.com
Message-Id: <c9a0cd9f-17cb-49e5-a411-b78ef9c7e35e@app.fastmail.com>
In-Reply-To: <281c3bb3-13f6-47a2-9a9a-134e397bf686@apertussolutions.com>
References: <20240531010331.134441-1-ross.philipson@oracle.com>
 <20240531010331.134441-7-ross.philipson@oracle.com>
 <20240531021656.GA1502@sol.localdomain>
 <874jaegk8i.fsf@email.froward.int.ebiederm.org>
 <5b1ce8d3-516d-4dfd-a976-38e5cee1ef4e@apertussolutions.com>
 <87ttflli09.ffs@tglx>
 <281c3bb3-13f6-47a2-9a9a-134e397bf686@apertussolutions.com>
Subject: Re: [PATCH v9 06/19] x86: Add early SHA-1 support for Secure Launch early
 measurements
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.15 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	TAGGED_FROM(0.00)[bounces-6194-lists,linux-efi=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[32];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[oracle.com,vger.kernel.org,kernel.org,lists.infradead.org,lists.linux-foundation.org,redhat.com,alien8.de,zytor.com,linux.intel.com,srcf.ucam.org,hansenpartnership.com,gmx.de,ziepe.ca,amacapital.net,alum.mit.edu,gondor.apana.org.au,davemloft.net,lwn.net,infradead.org,citrix.com,googlegroups.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[app.fastmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ardb@kernel.org,linux-efi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-efi];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: CC0CE168F11
X-Rspamd-Action: no action

Coming back to this old thread after having spent some time playing with the code:

On Thu, 22 Aug 2024, at 20:29, Daniel P. Smith wrote:

<selective snip>

> Another fact to consider is that the current Intel's TXT MLE 
> specification dictates SHA1 as a valid configuration. Secure Launch's 
> use of SHA1 is therefore to comply with Intel's specification for TXT. 

As I understand the Intel TXT spec and the code:

- TPM 1.2 is no longer supported by the TXT spec (since 2023)
- TPM 1.2 is not supported by your GRUB implementation
- in TPM 2.0 mode, SHA1 is only supported by the TXT spec if it is the /only/ algo supported by the TPM
- the proposed kernel implementation ignores any SHA-384 and SM3-256 PCR banks if they are active, and caps them using a { 1, 0, ... } fake digest.

So apologies for being slow, but I still struggle to understand why it is so important to have a SHA-1 implementation to cap those PCRs. Is it just to support systems with a TPM 2.0 that only has SHA-1 banks enabled?

Assuming that this code will get merged this year, it will be in a LTS branch by 2027, by which time distros like Debian will pick it up. 

I fully understand that this code has lived out-of-tree for more than a decade, and you likely prefer to get everything upstream that your current users may be relying on. But for Linux, this is a new feature, and merging code now that is basically obsolete on day 1 is not something we should entertain imo.

(and apologies for re-opening yet another can of worms - I assure you I am trying to be constructive here)

-- 
Ard.


