Return-Path: <linux-efi+bounces-6118-lists+linux-efi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-efi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SIEHL7Y6jmmeBAEAu9opvQ
	(envelope-from <linux-efi+bounces-6118-lists+linux-efi=lfdr.de@vger.kernel.org>)
	for <lists+linux-efi@lfdr.de>; Thu, 12 Feb 2026 21:40:22 +0100
X-Original-To: lists+linux-efi@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 36FA1130F79
	for <lists+linux-efi@lfdr.de>; Thu, 12 Feb 2026 21:40:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 508713046ABE
	for <lists+linux-efi@lfdr.de>; Thu, 12 Feb 2026 20:40:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3483130E0E5;
	Thu, 12 Feb 2026 20:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KXzgwHy4"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F4BC26E6FA;
	Thu, 12 Feb 2026 20:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770928817; cv=none; b=TOctLu6Vr0rD6/raxX/RYnsTwipOJsvYxp8byjvyI71V5U/PuADYy8irkxJs+fu6wzoiAw1Qv9rslviLxmBlbDlH37gBeoeVzLNVhbx3lh7Wkhg5NzDedSJTYE2kVjo5T2vLQrTkU9RJVQkBbWtb5UDoHMJDAX+iEXZWkQHR+7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770928817; c=relaxed/simple;
	bh=9Gc0/ilN7j5yF1KCkiGbXMqDqnOtVI+V0w9htJ9T/qI=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=qCWvvv1SEC4cMy31y/YJl+ZLYKS/a6HEXxaekgNW+LSkWKe7UP3UHOFCtnzWn365CWy3zDEncDZTDriPGl2jNGkcj3SAnobKhHY2ZOmqOmDnsteGaj2TuKiUDz9/r8nI8aXQBj7EfTkCjWbWva5MTW++4LYDKWtHJwqIhAMzpHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KXzgwHy4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00C70C4AF0B;
	Thu, 12 Feb 2026 20:40:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770928816;
	bh=9Gc0/ilN7j5yF1KCkiGbXMqDqnOtVI+V0w9htJ9T/qI=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=KXzgwHy4ws7X1BseHR09zXzvHUamgT75fcqq05Sw/siWUxQifEmpBeqR9qldRbbCl
	 kBV3/0LlJQnSDu6h4Jii2YbfG9mu5nFg9S+A6e3HmcFofVMw3lFdgna2wEPcssfHTj
	 +kNmlcORJkQTBe3XEbhzFpAVhSkDgM1mIK2vKSHKHDZE8wpBLUuXaXBLcg/Y0LI7Jx
	 NcpmoTg6GPUDn6Q/rrN48+M7JDCHtAh15cnNfDimi9U3foFQXJsJ4br4ZCW9PNj3fj
	 GtK9xyT2rz/8X/sSNn20jxKMihQFgTHT8VTe5ntFJ77AsGBwxJgGpHGfdBkP2EFWDo
	 wrPTYuAgZ6NvA==
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id AE1FCF4006C;
	Thu, 12 Feb 2026 15:40:14 -0500 (EST)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-01.internal (MEProxy); Thu, 12 Feb 2026 15:40:14 -0500
X-ME-Sender: <xms:rjqOaX0QLjTIfy27c3wPaNPIRvNddaaHAuyOUVu65QyF9gEOyAs6zg>
    <xme:rjqOaQ4nOA_FKbInLAEV68q_4hRhnK5woPvU4rhlsRJsEeBhoAP1d3gKSotK4yszU
    diS42BC7lux8IKxLTptldNVApg6wW4ayjZ8Tsqczw3Wf-rNLaD_vxBU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvtdeifeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnegouf
    hushhpvggtthffohhmrghinhculdegledmnecujfgurhepofggfffhvfevkfgjfhfutgfg
    sehtjeertdertddtnecuhfhrohhmpedftehrugcuuehivghshhgvuhhvvghlfdcuoegrrh
    gusgeskhgvrhhnvghlrdhorhhgqeenucggtffrrghtthgvrhhnpeefieefjeetgefhieff
    vdekkeduvdejvddtgfduteehgeefjeekudeltefhkeeugeenucffohhmrghinhepghhith
    hhuhgsrdhiohenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhr
    ohhmpegrrhguodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduieejtdehtd
    dtjeelqdeffedvudeigeduhedqrghruggspeepkhgvrhhnvghlrdhorhhgseifohhrkhho
    fhgrrhgurdgtohhmpdhnsggprhgtphhtthhopeefuddpmhhouggvpehsmhhtphhouhhtpd
    hrtghpthhtohepsghpsegrlhhivghnkedruggvpdhrtghpthhtohepnhhivhgvughithgr
    segrlhhumhdrmhhithdrvgguuhdprhgtphhtthhopehluhhtohesrghmrggtrghpihhtrg
    hlrdhnvghtpdhrtghpthhtohepughpshhmihhthhesrghpvghrthhushhsohhluhhtihho
    nhhsrdgtohhmpdhrtghpthhtoheprghnughrvgifrdgtohhophgvrhefsegtihhtrhhigi
    drtghomhdprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghp
    thhtohepphgvthgvrhhhuhgvfigvsehgmhigrdguvgdprhgtphhtthhopehhvghrsggvrh
    htsehgohhnughorhdrrghprghnrgdrohhrghdrrghupdhrtghpthhtohepthhrvghntghh
    sghoohhtqdguvghvvghlsehgohhoghhlvghgrhhouhhpshdrtghomh
X-ME-Proxy: <xmx:rjqOadtbwIiIHCnUd_j9VP7bPDaeG7coXIhqRD0RRlF78n6PWXxVDA>
    <xmx:rjqOaauqeXbCkuhSUhTE9F-LaZrj4ZUdQ7dIm_TxvXkV89BcojG4Kw>
    <xmx:rjqOadsEr2p-s1zIBvnLMZp83TwcrlzaN8RCINinXrErvtqAAuGemQ>
    <xmx:rjqOaS5UVfIV_ibP30J--5sFuG6QylqzdCiG0GQBcc3n12cZjFu8gw>
    <xmx:rjqOaYB2PGF9YI179RUmYGnz5ol4bRje39RPhYrrBFzGH_3ioDmVMikp>
Feedback-ID: ice86485a:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 7FC76700065; Thu, 12 Feb 2026 15:40:14 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AAnEvm6syrbF
Date: Thu, 12 Feb 2026 21:39:53 +0100
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
Message-Id: <49d169bf-0ad2-49be-b7d7-fceb9e7f831a@app.fastmail.com>
In-Reply-To: <1ffd3cb5-2c76-4371-a067-3e4849907d80@apertussolutions.com>
References: <20251215233316.1076248-1-ross.philipson@oracle.com>
 <b5f2b5a5-b984-4ed3-a023-c06d634f9146@app.fastmail.com>
 <1ffd3cb5-2c76-4371-a067-3e4849907d80@apertussolutions.com>
Subject: Re: [PATCH v15 00/28] x86: Secure Launch support for Intel TXT
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.15 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-6118-lists,linux-efi=lfdr.de];
	FREEMAIL_CC(0.00)[linutronix.de,redhat.com,alien8.de,zytor.com,srcf.ucam.org,hansenpartnership.com,gmx.de,kernel.org,ziepe.ca,amacapital.net,alum.mit.edu,gondor.apana.org.au,davemloft.net,lwn.net,xmission.com,infradead.org,linux.intel.com,oracle.com,citrix.com,googlegroups.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[31];
	DBL_BLOCKED_OPENRESOLVER(0.00)[app.fastmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ardb@kernel.org,linux-efi@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	PRECEDENCE_BULK(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-efi];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 36FA1130F79
X-Rspamd-Action: no action

On Thu, 12 Feb 2026, at 20:49, Daniel P. Smith wrote:
> On 2/9/26 09:04, Ard Biesheuvel wrote:
...
>> Surprisingly, even when doing a secure launch, the EFI runtime services still work happily, which means (AIUI) that code that was excluded from the D-RTM TCB is still being executed at ring 0? Doesn't this defeat D-RTM entirely in the case some exploit is hidden in the EFI runtime code? Should we measure the contents of EfiRuntimeServicesCode regions too?
>
> Yes, in fact in the early days I specifically stated that we should 
> provide for the ability to measure the RS blocks. Particularly if you 
> are not in an environment where you can isolate the calls to RS from the 
> TCB. While the RS can pose runtime corruption risks, the larger concern 
> is integrating the D-RTM validation of the Intel System Resources 
> Defense (ISRD), aka SMI isolation/SMM Supervisor, provided by the Intel 
> System Security Report (ISSR). Within the ISSR is a list of memory 
> regions which the SMM Policy Shim (SPS) restricts a SMI handler's access 
> when running. This allows a kernel to restrict what access a SMI handler 
> are able to reach, thus allowing them to be removed from the TCB when 
> the appropriate guards are put in place.
>
> If you are interested in understanding these further, Satoshi Tanda has 
> probably the best technical explanation without Intel market speak.
>
> ISRD: https://tandasat.github.io/blog/2024/02/29/ISRD.html
> ISSR: https://tandasat.github.io/blog/2024/03/18/ISSR.html
>

Thanks, I'll take a look at those.

But would it be better to disable the runtime services by default when doing a secure launch? PREEMPT_RT already does the same.

> While you all care about Linux specifically, the 
> goal for TrenchBoot is to build a common approach that we can implement
> across any other open source OS.
>

I'd argue that relying on things like setup_header, boot_params and kernel_info is not a great way to achieve that. The reason I care about this is that you are relying on those things even when doing EFI boot, which makes your approach highly Linux/x86 specific.

Given that arm64 has no decompressor at all, it is highly likely (and acceptable) that only EFI boot can do a secure launch. It also implies that the core kernel is the only place where we can put the pieces that execute afterwards. So adopting a model now for x86 that we know does not generalize well across other architectures is something I am not keen on.

...
>> I've had a stab at implementing all of this in a manner that is more idiomatic for EFI boot:
>> 
>> - GRUB does minimal TXT related preparation upfront, and exposes the remaining functionality via a protocol that is attached to the loaded image by GRUB
>> - The SL stub is moved to the core kernel, with some startup code added to pivot to long mode
>> - the EFI stub executes and decompresses the kernel as usual
>> - if the protocol is present, the EFI stub calls it to pass the bootparams pointer, the base and size of the MLE and the header offset back to the GRUB code
>> - after calling ExitBootServices(), it calls another protocol method to trigger the secure launch.
>> 
...
>
> I think this is a great approach for UEFI, though we need to reconcile 
> this with non-UEFI situations such as booting under coreboot.

There are two approaches that I think are feasible for coreboot in this model:

- just unpack the ELF and boot that - there is already prior art for that with Xen. We can stick the MLE header offset in an ELF note where any loader can find it.

- stick with the current approach as much as possible, i.e., disable physical KASLR so that the decompressed kernel will end up right where the decompressor was loaded, which allows much of the secure launch preparation to be done as before. Only the final bits (including the call into the ACM itself) need to be deferred, and we can propose a generic mechanism for that via boot_params.

I'm working on a prototype of the latter, but GRUB is an odd beast and my x86 fu is weak.

I'd be happy to have a call to compare notes and see if we can come up with something we can all agree on (modulo the SHA-1 :-))



