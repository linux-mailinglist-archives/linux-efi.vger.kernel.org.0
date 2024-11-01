Return-Path: <linux-efi+bounces-2099-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B5EF39B997D
	for <lists+linux-efi@lfdr.de>; Fri,  1 Nov 2024 21:34:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E828A1C21C8E
	for <lists+linux-efi@lfdr.de>; Fri,  1 Nov 2024 20:34:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3E451D5AA3;
	Fri,  1 Nov 2024 20:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JeAOcNd9";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="veMIp8Hu"
X-Original-To: linux-efi@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 270001CC8A7;
	Fri,  1 Nov 2024 20:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730493269; cv=none; b=FKtJML3pmQ3K4iPHcWeVnCHnQ3gzOA6NOFpc2tPuTyZBuo4HJfe3soT0VL4MR8JDsmKIUDG+8kkihijpUe35NmBqw1gOJUeMZ0QC+5Ad2+xiI+h9s9Etx0gN1guzVkPq9uEXuB3HRKw7FIdtK/M2/l3EfdMLY8Ueq04qKOXZDws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730493269; c=relaxed/simple;
	bh=y5wYIh4mE+JQUP17Jx8UhGwMOPLcQWAMz4GHTnF7p18=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=g5YBQbgpfpnUAzoeOSZkdth5BN1Dw+ERXZFZZFWWo1EYxqtDRtTm4+v1GhvcGlaNIpDk6/Hlc70D6aodfYfsXDt53s58Wc7PH9l9AqUXeI/MqdvO0ushCEPLFTjAWcKxQGd351cso4w5oMgGnPJQN+PMO8xs8y4hFAT2n6rNAdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JeAOcNd9; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=veMIp8Hu; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730493266;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=59h/4FnoLZZk0MjKW721si8AWaLkimLKPstUwXjURkM=;
	b=JeAOcNd9zrq7bXVafXOI2+VYSzyPRw9xhEyPY0SVc0xT2OTXiKahuugI6qbZlJXLpmgXdz
	S/DifpCHtGqRY77d4wpWjRyJY7j2tylDedWjt65ZEhiNjiZSeEOtRH21gcq9Hk0ZyMrP7G
	LOIMQhkAxoAsPe8PnwY42kXvpcPVqAZIYgCfLSh6SJfsTQQr/5RAqfl3q2oKQyk4Ltxa7+
	OIHZdyKZJnhBvKZQKt2IHL6yOoa9mnTcLfdL4qDvhLoRv6D8u7IaiccpXqnsEbT4G8diNJ
	n1wYxp5K/qPOc7dJvFwjgG/24Zuj2pRmN+72r0Z/SLTwxo0yreEGuOo062oJ0g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730493266;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=59h/4FnoLZZk0MjKW721si8AWaLkimLKPstUwXjURkM=;
	b=veMIp8Hu1Fbb53XXy+Sfvp5sOohtY6hRYmZZOUX8zQcskFrKrTVCheUAX3OX4Z0hp6Iatx
	V3AWbIBcUUOY/lBA==
To: Jarkko Sakkinen <jarkko@kernel.org>, Ross Philipson
 <ross.philipson@oracle.com>, linux-kernel@vger.kernel.org, x86@kernel.org,
 linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-crypto@vger.kernel.org, kexec@lists.infradead.org,
 linux-efi@vger.kernel.org, iommu@lists.linux-foundation.org
Cc: dpsmith@apertussolutions.com, mingo@redhat.com, bp@alien8.de,
 hpa@zytor.com, dave.hansen@linux.intel.com, ardb@kernel.org,
 mjg59@srcf.ucam.org, James.Bottomley@hansenpartnership.com,
 peterhuewe@gmx.de, jgg@ziepe.ca, luto@amacapital.net,
 nivedita@alum.mit.edu, herbert@gondor.apana.org.au, davem@davemloft.net,
 corbet@lwn.net, ebiederm@xmission.com, dwmw2@infradead.org,
 baolu.lu@linux.intel.com, kanth.ghatraju@oracle.com,
 andrew.cooper3@citrix.com, trenchboot-devel@googlegroups.com
Subject: Re: [PATCH v11 00/20] x86: Trenchboot secure dynamic launch Linux
 kernel support
In-Reply-To: <D5ARS5Y7EATS.2GVNSARKXKIDI@kernel.org>
References: <20240913200517.3085794-1-ross.philipson@oracle.com>
 <D5ARS5Y7EATS.2GVNSARKXKIDI@kernel.org>
Date: Fri, 01 Nov 2024 21:34:25 +0100
Message-ID: <87a5eivgku.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Nov 01 2024 at 12:28, Jarkko Sakkinen wrote:
> On Fri Sep 13, 2024 at 11:04 PM EEST, Ross Philipson wrote:
>> A quick note on terminology. The larger open source project itself is called
>> TrenchBoot, which is hosted on Github (links below). The kernel feature enabling
>> the use of Dynamic Launch technology is referred to as "Secure Launch" within
>> the kernel code. As such the prefixes sl_/SL_ or slaunch/SLAUNCH will be seen
>> in the code. The stub code discussed above is referred to as the SL stub.
>
> 1. I don't see any tags in most of the patches so don't get the rush. This
>    includes also patches for x86. Why I would care to review TPM patches
>    when there is over a dozen unreviewed and untested patches before it?
> 2. TPM patches have been in circulation in and out of the patch set
>    for some time now with little or no improvement.
>
> Why the sudden buzz? I have not heard much about this since last early
> summer.  Have to spend some time recalling what this is about anyway. I
> cannot trust that my tags make any sense before more reviewed/tested-by
> tags before the TPM patches.

If I intend to merge the patches then I surely have looked at them
deeply. I don't have to send a reviewed-by just to apply them
afterwards.

There was enough motion on these patches and this posting is in your
inbox for 6 weeks now without any reaction from you.

The TPM changes are very much independent from the x86 specific ones, so
why do you want x86 review tags in order to look at the ones which are
specific to your subsystem especially as some of them seem to address
real short comings there independent of trenchboot.

Thanks,

        tglx

