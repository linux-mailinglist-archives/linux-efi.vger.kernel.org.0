Return-Path: <linux-efi+bounces-6227-lists+linux-efi=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-efi@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EIijMmbKoGmlmgQAu9opvQ
	(envelope-from <linux-efi+bounces-6227-lists+linux-efi=lfdr.de@vger.kernel.org>)
	for <lists+linux-efi@lfdr.de>; Thu, 26 Feb 2026 23:34:14 +0100
X-Original-To: lists+linux-efi@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B4AD1B06EA
	for <lists+linux-efi@lfdr.de>; Thu, 26 Feb 2026 23:34:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AE3FD302BBA5
	for <lists+linux-efi@lfdr.de>; Thu, 26 Feb 2026 22:34:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6466C396B82;
	Thu, 26 Feb 2026 22:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o4ja91eE"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C998316905;
	Thu, 26 Feb 2026 22:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772145249; cv=none; b=sJu3mi/DgUqvVV6sg414XZXHzv1D1YOIMLAq8MINFbQBqj5hoN/c40yUiVXFz4xnStNh9lLxqpi8T4T4/IfX5pFULtAsLyxuLLBxU21vKTXam81WzAa4aYS5NHfwF/c/96YCUkDiSM5VTgY62O9dZ+2Eebkd5ChcFDsDjWXP4+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772145249; c=relaxed/simple;
	bh=sqVu4bH4eVU4Te9XYoGx3Yasl2SZId3A32JcMRFb2I0=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=ZmEB3hLnNmBTBoIY7iSVftpgfHLChEQNuFtJNpR2le0W1+GI8Jact5v5scMWMPbXCeBZeiWjNeY7dA5fKiS3bKMGUXm54QaZTDS1bcE9P+AM/zX6xw870YMEN4S/56IEBv75ay55PNDRGbL35k8SfnyP99ZPhbwlWycOdwu9UlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o4ja91eE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37AE4C116C6;
	Thu, 26 Feb 2026 22:34:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772145249;
	bh=sqVu4bH4eVU4Te9XYoGx3Yasl2SZId3A32JcMRFb2I0=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=o4ja91eEz1c1WxYRLFM/BlXla8b7+KKl7474XcSZb/Ezh3iEyFnVvVJbsxWuev0Sj
	 f8lNKtgWHEi211lf3g7ZjDuuV3qJJdkiwdERLFIoFOfU9YfqAbrr/yWm0H0nXPtRnC
	 4P1bXS/9XuF/ghMf1VnjTJzxGynnKsW2vk2g+iYjvKbi2+WdlQQEjgGqxQeBpNvR+/
	 TVqNLjYKwJnyuY97ImZz+R2RzQRRu+pNnuzcNZgRGCEVtmnht4bUvCuoQ1hYO4FA4y
	 V0/hmUE5T6/p6PQicQD6MxZZ/jVuYVVpCRtAMkCaaGa7sXUq3QwwPaRdnM+Js2XZsR
	 jocp2qaSJRWLQ==
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id 1BE2DF40070;
	Thu, 26 Feb 2026 17:34:07 -0500 (EST)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-01.internal (MEProxy); Thu, 26 Feb 2026 17:34:07 -0500
X-ME-Sender: <xms:XsqgaYFayPBqywQPSAayqE2OVLMApPLJKmW31lIYbGsq1JqeNeh-Ww>
    <xme:XsqgacJCGa88NfDG4sRtPjylUJ8EBO3eG9F8jMkGDmY7eJPXx_CIpRJIRLWzLtKBF
    1yksO_AEncEVQgm0ZyY403x4yWulBnxCicFS21ZpKRjBEllM2Xpqg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvgeejfedtucetufdoteggodetrf
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
X-ME-Proxy: <xmx:X8qgab_C081BMvaxIo0BzZ-sX_AZdakByebOHAHonhOZKthOofNYdg>
    <xmx:X8qgab9RXeBduiNjH9ukeTnmcessPmjZE_P_BsB_B3rT4zvP43haPw>
    <xmx:X8qgaV8gKWfgApMxNXUIy-8AXoKZAbHjsRXX-zZwcEBpHJWpDTdjUQ>
    <xmx:X8qgaWKju_xbONK3Zq2I1tNt_fC0oFtXwcuR9Tme3zbaJ9rR1f7jDA>
    <xmx:X8qgaaTn5NUoqETkYMa2Chsu7s32beRqVWFyyUQOMzedJpvBW4TIhqOR>
Feedback-ID: ice86485a:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id E001E700065; Thu, 26 Feb 2026 17:34:06 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AAnEvm6syrbF
Date: Thu, 26 Feb 2026 23:33:18 +0100
From: "Ard Biesheuvel" <ardb@kernel.org>
To: "Ross Philipson" <ross.philipson@oracle.com>,
 "Daniel P. Smith" <dpsmith@apertussolutions.com>,
 linux-kernel@vger.kernel.org, x86@kernel.org,
 linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-crypto@vger.kernel.org, kexec@lists.infradead.org,
 linux-efi@vger.kernel.org, iommu@lists.linux.dev,
 dave.hansen@linux.intel.com, "H . Peter Anvin" <hpa@zytor.com>
Cc: "Thomas Gleixner" <tglx@linutronix.de>, "Ingo Molnar" <mingo@redhat.com>,
 "Borislav Petkov" <bp@alien8.de>, "Matthew Garrett" <mjg59@srcf.ucam.org>,
 "James Bottomley" <James.Bottomley@hansenpartnership.com>, peterhuewe@gmx.de,
 "Jarkko Sakkinen" <jarkko@kernel.org>, jgg@ziepe.ca,
 "Andy Lutomirski" <luto@amacapital.net>, nivedita@alum.mit.edu,
 "Herbert Xu" <herbert@gondor.apana.org.au>, davem@davemloft.net,
 corbet@lwn.net, "Eric W. Biederman" <ebiederm@xmission.com>,
 dwmw2@infradead.org, baolu.lu@linux.intel.com, kanth.ghatraju@oracle.com,
 "Andrew Cooper" <andrew.cooper3@citrix.com>,
 trenchboot-devel@googlegroups.com
Message-Id: <517b0d68-247b-486a-b283-84eac6596017@app.fastmail.com>
In-Reply-To: <00774604-258c-4e88-80a4-fd8f60fcd0b3@oracle.com>
References: <20251215233316.1076248-1-ross.philipson@oracle.com>
 <b5f2b5a5-b984-4ed3-a023-c06d634f9146@app.fastmail.com>
 <1ffd3cb5-2c76-4371-a067-3e4849907d80@apertussolutions.com>
 <49d169bf-0ad2-49be-b7d7-fceb9e7f831a@app.fastmail.com>
 <242a0462-7fc5-4902-b71d-22cf8360239e@app.fastmail.com>
 <00774604-258c-4e88-80a4-fd8f60fcd0b3@oracle.com>
Subject: Re: [PATCH v15 00/28] x86: Secure Launch support for Intel TXT
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.15 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	TAGGED_FROM(0.00)[bounces-6227-lists,linux-efi=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[31];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linutronix.de,redhat.com,alien8.de,srcf.ucam.org,hansenpartnership.com,gmx.de,kernel.org,ziepe.ca,amacapital.net,alum.mit.edu,gondor.apana.org.au,davemloft.net,lwn.net,xmission.com,infradead.org,linux.intel.com,oracle.com,citrix.com,googlegroups.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,app.fastmail.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
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
X-Rspamd-Queue-Id: 0B4AD1B06EA
X-Rspamd-Action: no action



On Thu, 26 Feb 2026, at 19:31, ross.philipson@oracle.com wrote:
> On 2/18/26 9:30 AM, 'Ard Biesheuvel' via trenchboot-devel wrote:
>> On Thu, 12 Feb 2026, at 21:39, Ard Biesheuvel wrote:
>>> On Thu, 12 Feb 2026, at 20:49, Daniel P. Smith wrote:
>>>> On 2/9/26 09:04, Ard Biesheuvel wrote:
>>> ...
>>>>> I've had a stab at implementing all of this in a manner that is more idiomatic for EFI boot:
>>>>>
>>>>> - GRUB does minimal TXT related preparation upfront, and exposes the remaining functionality via a protocol that is attached to the loaded image by GRUB
>>>>> - The SL stub is moved to the core kernel, with some startup code added to pivot to long mode
>>>>> - the EFI stub executes and decompresses the kernel as usual
>>>>> - if the protocol is present, the EFI stub calls it to pass the bootparams pointer, the base and size of the MLE and the header offset back to the GRUB code
>>>>> - after calling ExitBootServices(), it calls another protocol method to trigger the secure launch.
>>>>>
>>> ...
>>>>
>>>> I think this is a great approach for UEFI, though we need to reconcile
>>>> this with non-UEFI situations such as booting under coreboot.
>>>
>>> There are two approaches that I think are feasible for coreboot in this model:
>>>
>>> - just unpack the ELF and boot that - there is already prior art for
>>> that with Xen. We can stick the MLE header offset in an ELF note where
>>> any loader can find it.
>>>
>>> - stick with the current approach as much as possible, i.e., disable
>>> physical KASLR so that the decompressed kernel will end up right where
>>> the decompressor was loaded, which allows much of the secure launch
>>> preparation to be done as before. Only the final bits (including the
>>> call into the ACM itself) need to be deferred, and we can propose a
>>> generic mechanism for that via boot_params.
>>>
>>> I'm working on a prototype of the latter, but GRUB is an odd beast and
>>> my x86 fu is weak.
>>>
>> 
>> I've managed to get a working implementation of the legacy entrypoint, by repurposing the dl_handler() entrypoint you added for EFI [which no longer needs it in my version] as a callback for the legacy boot flow. This /should/ work for i386-coreboot too, but I have no way of testing it (I only tried 'slaunch --legacy-linux' using the x86_64-efi build).
>> 
>> I've pushed the changes to the branches I mentioned previously in this thread.
>
> Hello Ard,
>
> I am working on incorporating the changes we have been discussing. So 
> far everything has been rather smooth. I noticed in the legacy support 
> you did here, you introduce a new boot_param. This is something that we 
> tried to do early on but changes to the boot_params layout is rather 
> frowned upon. We worked with Peter A. on the kernel_info scheme but 
> this parameter you introduced is not used that way (kernel_info is 
> meant to be RO after the kernel is built).

Indeed. kernel_info describes the kernel to the bootloader, not the other way around.

There is prior art for adding fields to boot_params for passing data from bootloader to kernel (e.g., ext_ramdisk_image/size, efi_info, cc_blob_address), and I think adding a field for the SLRT is reasonable. Alternatively, we might consider setup_data but I don't see why a field in boot_params would be controversial here.

> I guess my first questions 
> are whether this will be an acceptable approach (per the x86 
> maintainers) to add a boot_param and, if so, whether the spot you chose 
> is reasonable. E.g. will it survive the sanitize boot params step.
>

I think that is irrelevant tbh. A bootloader is supposed to clear struct boot_params before it copies struct setup_header into it, otherwise sanitize_boot_params() will trigger on a non-zero sentinel field, and clean it up. Given that there is no backwards compatibility concern for trenchboot, we can just stipulate that the SLRT field is only valid if struct boot_params was wiped correctly, and sanitize_boot_params() will be a no-op.




