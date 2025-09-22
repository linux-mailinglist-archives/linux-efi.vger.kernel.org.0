Return-Path: <linux-efi+bounces-4929-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 569F5B9046B
	for <lists+linux-efi@lfdr.de>; Mon, 22 Sep 2025 12:52:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3BA154E0690
	for <lists+linux-efi@lfdr.de>; Mon, 22 Sep 2025 10:52:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCFF0287268;
	Mon, 22 Sep 2025 10:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=whynothugo.nl header.i=@whynothugo.nl header.b="Ow9LCl1e";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Yc8oCpWm"
X-Original-To: linux-efi@vger.kernel.org
Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36FA978F43;
	Mon, 22 Sep 2025 10:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758538329; cv=none; b=SQR0iQFAzlTsFcNNh+ch4zTqKHGqURXRzVht/KVHtKBR8NprwJGSqPcRRyOylylClM0YuJmnEl/okEwC+3RbNpQ1PsTY0UaezLE5a69PeSC0e9U0QxRvVegLRB6WRVBQBbucJwO6roEw1uS34A9SIpwr5+kdhcBT9DfkgwDAR/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758538329; c=relaxed/simple;
	bh=XTJ6Eaj/i446zNXmwj9Zmnd5ozBQVqnlIGt1oWtpAL4=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=Hn0kN0aPCSTEM/vuSB20NZ4q7IrqzTAUFciGi65SXOKRGT2fxotUUQO7X8VuR8rpZmOPfjis2WA3p6QhCYuMlNGYOaMCq4X0qfwFATfCwvMriLdSPDg2JBZbbRqVzRXtdeQ4CKlIGGdsQuzOxsk2ZnHiCy4pwWPnBVBoIrAqf2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=whynothugo.nl; spf=pass smtp.mailfrom=whynothugo.nl; dkim=pass (2048-bit key) header.d=whynothugo.nl header.i=@whynothugo.nl header.b=Ow9LCl1e; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Yc8oCpWm; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=whynothugo.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=whynothugo.nl
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 120221400030;
	Mon, 22 Sep 2025 06:52:06 -0400 (EDT)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-10.internal (MEProxy); Mon, 22 Sep 2025 06:52:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=whynothugo.nl;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm2;
	 t=1758538326; x=1758624726; bh=z72JMyrHj5yss06Ds7unVYneJe0p/rLi
	/xZ/DsNUCTk=; b=Ow9LCl1egC3lCr8HL7YPTutRkXtKOruJA1DFdVni89IKAXQs
	+ql3EMNKNtVkUWJWfJtCp/8AtHLGRuI9Cl+grnDqyJ6LAyWiFtTEmjwSfVkORrTW
	krsF3M9eE5G3TZYDBVF7oflp6BElRGZ/tY62OGXGQyUc9IGRVJ9g/fHlSHk3uH6T
	KCpjZw21kKgkIstcEN/lA4Z19zY/RddKyn3PWwPbluIeM0vuQdFimU2Cv+Y/hhMc
	qczOomesvy89MP+Dl7riPiCCoTjcVAehrWRI4i6KHgu7kWNCDfJSy70DwqkXnRFY
	lnVSbjRIXK+2uB2vrA4HEnvYcuEat3KL4S57AQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1758538326; x=
	1758624726; bh=z72JMyrHj5yss06Ds7unVYneJe0p/rLi/xZ/DsNUCTk=; b=Y
	c8oCpWmM9v6eNHPE3vJTiNVoVI7PR5jddv+zij4uk0c+1Dq5wCH47/yvF9qdmQ0F
	o8uGK1ChMewhqj72qrPcqwNZrliLPPLMmMQEQo73hqs8vOIoklqWadSxyGNZWK9i
	TbYQ3fte/Y/wjFMd7wD1rbeg3qVS3oKhqaGY7MaDbQqLOfMhQ8A8m02xCkmJY1me
	Wzi92KD/Cfkvv6dWGVWEEpqLg5X2MrC2RrKAPGWhb0+7E//UjyE44jd+zt8wxguo
	GWngOXlxi0PEjgEheyZ5O2wopAmTA91UuFVkCDRdwhCHgTZ7P6jeHUx/QKfjMixi
	rL3TDX9+2uzRRqQeiftVA==
X-ME-Sender: <xms:VSrRaIHp1lsLaHpjfv8-EcDpUDP6qoSdmVKguAUfH3MPcM2Z-cGT0A>
    <xme:VSrRaBVuLZn_ostKCSq-kFmA15TiGFmwI2mJcIXXNEMdTMkmOV6_X0-pFaQG-eX5b
    GAVpkIkwaRKEOTngA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdehjeeihecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdfjuhhgohcu
    qfhsvhgrlhguohcuuegrrhhrvghrrgdfuceohhhughhoseifhhihnhhothhhuhhgohdrnh
    hlqeenucggtffrrghtthgvrhhnpeevgeffgfeiffegteelteekhefgfffhkeffudfgfffh
    ueegveevuedthedthedujeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluh
    hsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhephhhughhoseifhhih
    nhhothhhuhhgohdrnhhlpdhnsggprhgtphhtthhopedufedpmhhouggvpehsmhhtphhouh
    htpdhrtghpthhtohepsghpsegrlhhivghnkedruggvpdhrtghpthhtohepsggrghgrshgu
    ohhtmhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtoheprhguuhhnlhgrphesihhnfhhrrg
    guvggrugdrohhrghdprhgtphhtthhopegrrhgusgeskhgvrhhnvghlrdhorhhgpdhrtghp
    thhtohepgiekieeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepthhglhigsehlihhnuh
    htrhhonhhigidruggvpdhrtghpthhtohepuggrvhgvrdhhrghnshgvnheslhhinhhugidr
    ihhnthgvlhdrtghomhdprhgtphhtthhopegtohhrsggvtheslhifnhdrnhgvthdprhgtph
    htthhopehmihhnghhosehrvgguhhgrthdrtghomh
X-ME-Proxy: <xmx:VSrRaOoGji-8EEOBgjo31hHhExSBb5_RcvpI_EvtoAMENvMO68dzOw>
    <xmx:VSrRaLK10USXWdPpAd0Z7FNicJzzbekiJU8zPWnlJosx6FGWkumlRQ>
    <xmx:VSrRaOuHvjCImCY6WFHLQUOGhgN2yxBTrhfQho0BBSMI8lx85s9xng>
    <xmx:VSrRaICUXOh1CPMYuny_xh8ei48Sa4ywtjHVxjj1WbLEcw1sbOa0eg>
    <xmx:VirRaKJYu7vb66KlQgycyuAuex9hQMQbnBczp70vVirByd00WHA_y_uc>
Feedback-ID: ib8c04050:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 4436C1B40071; Mon, 22 Sep 2025 06:52:05 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Ar2Xryr4sLlg
Date: Mon, 22 Sep 2025 12:51:43 +0200
From: "Hugo Osvaldo Barrera" <hugo@whynothugo.nl>
To: "Jonathan Corbet" <corbet@lwn.net>,
 "Bagas Sanjaya" <bagasdotme@gmail.com>,
 "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
 "Linux Documentation" <linux-doc@vger.kernel.org>,
 "Linux EFI" <linux-efi@vger.kernel.org>
Cc: "Ard Biesheuvel" <ardb@kernel.org>,
 "Thomas Gleixner" <tglx@linutronix.de>, "Ingo Molnar" <mingo@redhat.com>,
 "Borislav Petkov" <bp@alien8.de>,
 "Dave Hansen" <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, "Randy Dunlap" <rdunlap@infradead.org>
Message-Id: <e8bb9bb3-f9ec-49bb-9884-af727ea61caf@app.fastmail.com>
In-Reply-To: <87zfaufrcq.fsf@trenco.lwn.net>
References: <20250916073244.590483-1-bagasdotme@gmail.com>
 <b629ff7e-a223-467f-8e32-78f825bd31ac@app.fastmail.com>
 <87zfaufrcq.fsf@trenco.lwn.net>
Subject: Re: [PATCH v2] Documentation/x86: explain LINUX_EFI_INITRD_MEDIA_GUID
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



On Tue, 16 Sep 2025, at 15:40, Jonathan Corbet wrote:
> "Hugo Osvaldo Barrera" <hugo@whynothugo.nl> writes:
>
>>> +When compiled with ``CONFIG_EFI_STUB=y``, the kernel can be executed 
>>> as a
>>> +regular PE/COFF binary. See Documentation/admin-guide/efi-stub.rst for
>>> +implementation details.
>>
>> I must insist that it's a terrible idea to replace an actual link with the
>> name of the source file.
>>
>> This might be (marginally) more convenient for somebody who's editing the
>> documentation, but it becomes completely useless for somebody who's READING
>> the documentation. Documentation needs to target readers.
>>
>> For someone reading https://www.kernel.org/doc/html/latest/arch/x86/boot.html,
>> the above filename conveys no useful information.
>
> When the documentation is rendered into HTML, that file reference will
> be turned into a link automatically, and people reading it on kernel.org
> will not notice the difference.
>

Thanks for the clarification.
I mis-interpreted this previously.
Sorry for the noise.


-- 
Hugo

