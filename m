Return-Path: <linux-efi+bounces-6175-lists+linux-efi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-efi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QBqLJGb3lWlMXgIAu9opvQ
	(envelope-from <linux-efi+bounces-6175-lists+linux-efi=lfdr.de@vger.kernel.org>)
	for <lists+linux-efi@lfdr.de>; Wed, 18 Feb 2026 18:31:18 +0100
X-Original-To: lists+linux-efi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 30FCB1584F3
	for <lists+linux-efi@lfdr.de>; Wed, 18 Feb 2026 18:31:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D5EDE300F10A
	for <lists+linux-efi@lfdr.de>; Wed, 18 Feb 2026 17:31:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8689E34403F;
	Wed, 18 Feb 2026 17:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="McudYyAS"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6330E341056;
	Wed, 18 Feb 2026 17:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771435863; cv=none; b=bGNYZ+Vo0gpiUA3BfAxI0uR10GQwjJrgYNkrfL3mdNa+rkWMjKlUj+oBfzrMQmYxATd1skm6NKlNLxlyYMr4/axxQ2DQe3OhwSC559feG3W1KgKJNrJEpucVGWn3CtxkByNR1KULE/PfZ/NmPZMnDSSqPgPYsDTqSGO8iniYJ34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771435863; c=relaxed/simple;
	bh=ohdYdo9+SBYLGFQheyzJQWf2ZP0wlboQxRYJXiSxQpA=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=u+B92KL6v+4AI/oezXyljBGsNePTFhAWB8OcpfB6CKztQEMx+mgjHCzv30c/JcQZWpKjYzP4Tvq6N7724IvaP/CnTH08m7kBy3ReLQs/TeDPueNfhqQus5lGIuVUJFbZtAAhgRYRFeyg/UIWYKdmx88lY9rubcfFBeD0I6jl6xY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=McudYyAS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2431DC2BC86;
	Wed, 18 Feb 2026 17:31:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771435863;
	bh=ohdYdo9+SBYLGFQheyzJQWf2ZP0wlboQxRYJXiSxQpA=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=McudYyASYCnIIknllTfbWeBasYF1a+luKCxCols6Jw1km/iGXUwoYW3W3o05vAnCP
	 uQI73Xj0m0QOtk8IDW0CMwgeJWU0Mr85kxlfN9Y4ab2wLEsWfTd8Fo/iHMI1UB4JGn
	 NaRyFxliiSd4hXGG9l/xg5a6A0/Fs/gGEtD//4hQAXKLdkWTS2/9wF4Xf72p5KdsyE
	 k88hJWPkj92E/G31RV10LRxMWtyRWUgOZ6zhKSqpU2D8DQFJzuhy70AwOOlh+kERVG
	 P5//LyQOgOd7O4cIupYxHJIOL1eCMHH+Nu89UGD26Ismw+279AjcuheOjtOjDIAbAj
	 bWoH1X9jLzNeg==
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id ECEEFF4006A;
	Wed, 18 Feb 2026 12:31:00 -0500 (EST)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-01.internal (MEProxy); Wed, 18 Feb 2026 12:31:00 -0500
X-ME-Sender: <xms:VPeVafpE2Ie32Cr6UQi9iwoHWZ9_Rr9MqAAo1vEXiVlQhmrDG617lQ>
    <xme:VPeVaUfOFGNo3VT8oEAE7hLFwJ9DpJ-RP2iVZBqnhASdxM4yGBbZBFJogZSNFZoBi
    CsfIPQE6VIiWkp0TRIRoowEEduygVFDFkG693K5qZVhnNLWZCeodK8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvvdefvdegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedftehrugcu
    uehivghshhgvuhhvvghlfdcuoegrrhgusgeskhgvrhhnvghlrdhorhhgqeenucggtffrrg
    htthgvrhhnpedvueehiedtvedtleekuddutefgffdtleetfeetveejveejieehfefhjeei
    jeefudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhguodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduieejtdehtddtjeel
    qdeffedvudeigeduhedqrghruggspeepkhgvrhhnvghlrdhorhhgseifohhrkhhofhgrrh
    gurdgtohhmpdhnsggprhgtphhtthhopeefuddpmhhouggvpehsmhhtphhouhhtpdhrtghp
    thhtohepsghpsegrlhhivghnkedruggvpdhrtghpthhtohepnhhivhgvughithgrsegrlh
    humhdrmhhithdrvgguuhdprhgtphhtthhopehluhhtohesrghmrggtrghpihhtrghlrdhn
    vghtpdhrtghpthhtohepughpshhmihhthhesrghpvghrthhushhsohhluhhtihhonhhsrd
    gtohhmpdhrtghpthhtoheprghnughrvgifrdgtohhophgvrhefsegtihhtrhhigidrtgho
    mhdprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtoh
    epphgvthgvrhhhuhgvfigvsehgmhigrdguvgdprhgtphhtthhopehhvghrsggvrhhtsehg
    ohhnughorhdrrghprghnrgdrohhrghdrrghupdhrtghpthhtohepthhrvghntghhsghooh
    htqdguvghvvghlsehgohhoghhlvghgrhhouhhpshdrtghomh
X-ME-Proxy: <xmx:VPeVabBa_wd2qiCyTsIYs17e1uoC1yTqNE-7TFe-OcghnALLLc-tIA>
    <xmx:VPeVaVyJm99RF_spmJcqwucqbb1AYRyIzzhpzFGiuxEuUOXhMZg0Ug>
    <xmx:VPeVaTjcWWUCCp0TUy9DYntPyyAuQ5IPaEAter_T9s7mH21bCLrzSw>
    <xmx:VPeVaceUTFrpzfQacbKuMEvVrz1H6P4BuyBUoxfBA2vA1uy_jqpcCA>
    <xmx:VPeVaaVtmATKPIh2w_we3MNdpdlcZTnTNlXcV8Tn0zN6tsgzgLNH-oJ0>
Feedback-ID: ice86485a:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id BAF30700065; Wed, 18 Feb 2026 12:31:00 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AAnEvm6syrbF
Date: Wed, 18 Feb 2026 18:30:39 +0100
From: "Ard Biesheuvel" <ardb@kernel.org>
To: "Daniel P. Smith" <dpsmith@apertussolutions.com>,
 "Ross Philipson" <ross.philipson@oracle.com>, linux-kernel@vger.kernel.org,
 x86@kernel.org, linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-crypto@vger.kernel.org, kexec@lists.infradead.org,
 linux-efi@vger.kernel.org, iommu@lists.linux.dev, dave.hansen@linux.intel.com
Cc: "Thomas Gleixner" <tglx@linutronix.de>, "Ingo Molnar" <mingo@redhat.com>,
 "Borislav Petkov" <bp@alien8.de>, "H . Peter Anvin" <hpa@zytor.com>,
 mjg59@srcf.ucam.org, James.Bottomley@hansenpartnership.com,
 peterhuewe@gmx.de, "Jarkko Sakkinen" <jarkko@kernel.org>, jgg@ziepe.ca,
 luto@amacapital.net, nivedita@alum.mit.edu,
 "Herbert Xu" <herbert@gondor.apana.org.au>, davem@davemloft.net,
 corbet@lwn.net, ebiederm@xmission.com, dwmw2@infradead.org,
 baolu.lu@linux.intel.com, kanth.ghatraju@oracle.com,
 andrew.cooper3@citrix.com, trenchboot-devel@googlegroups.com
Message-Id: <242a0462-7fc5-4902-b71d-22cf8360239e@app.fastmail.com>
In-Reply-To: <49d169bf-0ad2-49be-b7d7-fceb9e7f831a@app.fastmail.com>
References: <20251215233316.1076248-1-ross.philipson@oracle.com>
 <b5f2b5a5-b984-4ed3-a023-c06d634f9146@app.fastmail.com>
 <1ffd3cb5-2c76-4371-a067-3e4849907d80@apertussolutions.com>
 <49d169bf-0ad2-49be-b7d7-fceb9e7f831a@app.fastmail.com>
Subject: Re: [PATCH v15 00/28] x86: Secure Launch support for Intel TXT
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.15 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	TAGGED_FROM(0.00)[bounces-6175-lists,linux-efi=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[31];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linutronix.de,redhat.com,alien8.de,zytor.com,srcf.ucam.org,hansenpartnership.com,gmx.de,kernel.org,ziepe.ca,amacapital.net,alum.mit.edu,gondor.apana.org.au,davemloft.net,lwn.net,xmission.com,infradead.org,linux.intel.com,oracle.com,citrix.com,googlegroups.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[app.fastmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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
X-Rspamd-Queue-Id: 30FCB1584F3
X-Rspamd-Action: no action

On Thu, 12 Feb 2026, at 21:39, Ard Biesheuvel wrote:
> On Thu, 12 Feb 2026, at 20:49, Daniel P. Smith wrote:
>> On 2/9/26 09:04, Ard Biesheuvel wrote:
> ...
>>> I've had a stab at implementing all of this in a manner that is more idiomatic for EFI boot:
>>> 
>>> - GRUB does minimal TXT related preparation upfront, and exposes the remaining functionality via a protocol that is attached to the loaded image by GRUB
>>> - The SL stub is moved to the core kernel, with some startup code added to pivot to long mode
>>> - the EFI stub executes and decompresses the kernel as usual
>>> - if the protocol is present, the EFI stub calls it to pass the bootparams pointer, the base and size of the MLE and the header offset back to the GRUB code
>>> - after calling ExitBootServices(), it calls another protocol method to trigger the secure launch.
>>> 
> ...
>>
>> I think this is a great approach for UEFI, though we need to reconcile 
>> this with non-UEFI situations such as booting under coreboot.
>
> There are two approaches that I think are feasible for coreboot in this model:
>
> - just unpack the ELF and boot that - there is already prior art for 
> that with Xen. We can stick the MLE header offset in an ELF note where 
> any loader can find it.
>
> - stick with the current approach as much as possible, i.e., disable 
> physical KASLR so that the decompressed kernel will end up right where 
> the decompressor was loaded, which allows much of the secure launch 
> preparation to be done as before. Only the final bits (including the 
> call into the ACM itself) need to be deferred, and we can propose a 
> generic mechanism for that via boot_params.
>
> I'm working on a prototype of the latter, but GRUB is an odd beast and 
> my x86 fu is weak.
>

I've managed to get a working implementation of the legacy entrypoint, by repurposing the dl_handler() entrypoint you added for EFI [which no longer needs it in my version] as a callback for the legacy boot flow. This /should/ work for i386-coreboot too, but I have no way of testing it (I only tried 'slaunch --legacy-linux' using the x86_64-efi build).

I've pushed the changes to the branches I mentioned previously in this thread.



 

