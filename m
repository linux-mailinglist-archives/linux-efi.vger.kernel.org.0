Return-Path: <linux-efi+bounces-3451-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CD93DA9A8A4
	for <lists+linux-efi@lfdr.de>; Thu, 24 Apr 2025 11:45:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE8AF1B85A13
	for <lists+linux-efi@lfdr.de>; Thu, 24 Apr 2025 09:45:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF6D1221FAF;
	Thu, 24 Apr 2025 09:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="USjHibLV"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 815A721C9F1;
	Thu, 24 Apr 2025 09:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745487485; cv=none; b=a039DRthmka7m6HcnZN8HT4r5f8ejfZ2ZW9q/7OVEAQPgysgwVO0eNsDYKTEDN87o6QXjMtdPfVz1cWxIGuf/6K9Wmo1/q5vPAYdF5n5sFUKRY5Avyqvfp1DVqXTc1iSY5tpsccIWt+mLDCayN7S6Y9VSypB2Ja6oONw7i/S0FA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745487485; c=relaxed/simple;
	bh=9kwF46iJORcY9TFOIlZtjm/YNpS0T5SJximkUDFlW60=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=NcyGq/btqzqEBFN9320zCLOpjwJohhf7Ga75TBFEUKzcM7JSMLESBuZ+DPA0sDOPPOTnkKijnsOwJ3jrAWHppagsM8aNM6FC9TKtXunvEgRFffqdE3WLZdFczor+Gbo0PrnnO7gMvqfFsNw+RI5uo3YZJQR4MvfHb+BK2tArLnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=USjHibLV; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id A828840E01ED;
	Thu, 24 Apr 2025 09:37:54 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id XNyt89XR2037; Thu, 24 Apr 2025 09:37:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1745487470; bh=dzIiNMjy0H4E0Jt/t7PcVoUSltod6To/hbE5oCVaQ8E=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=USjHibLVo3pFcy3R9wI9oTDCVXEZuDWfA+B6EXabjE8FArtrbas5oKoAI+L60Izvy
	 gY1UqWwwzQLeRjTlu/vmnmJdsWAM3aCa22Al3sLbBPIDqpOCza5SN9zsjgzTAAxwLQ
	 3WZd9F3Hn+27SUey24ZrxmkvqW7oVnEgUur7mWVo5Pr/rKlHg/BcuW3trgR5PPGzFZ
	 jF2kBkPnWGm/Gnl91KTLejxm4HdEL+BB0KY8dgQ0p+B3uK6miQGqiq6MW85iVlq29l
	 4e+wpm24sJkqwxmPXNqB1pv9Di1gHqa39Zetp18F6BQLi6OpvmI9rSk4CIqil9qkZO
	 jvQGqeEdjWrjKwGfpK0LEWAwSEXG532YHiIUDQJlmST04tm/eZn0ZKB9XCtfiB0AMD
	 r5ZB8fsqd6ABsy09UFOOxAxOS05OIgXo5q8P57UMmcmBn9daIU274nin8EIQpdCOX3
	 ldJEdddi6cY5nrABYTx2s4Y98DAEa9W2Dn9NEAcJh7JVdoKXkJM3OGeCRFgqB4MzhX
	 jcTBhmiifs65vBuLJGcFL0xmfR0wusB89itmTRK3zBAR85ZY5Isf+D+um+2BNYkhVs
	 NzSbqONuz5EgNeiG52eQXf3TO7yndT2X1fOIIeqX7qEpf/N1HyMACq/V95DsrS0xYg
	 7wo9DlxYbIOIwLfDy1dbqZ18=
Received: from [127.0.0.1] (unknown [78.130.214.207])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 87E5640E021A;
	Thu, 24 Apr 2025 09:37:41 +0000 (UTC)
Date: Thu, 24 Apr 2025 12:37:38 +0300
From: Borislav Petkov <bp@alien8.de>
To: Ard Biesheuvel <ardb@kernel.org>, Tom Lendacky <thomas.lendacky@amd.com>
CC: Ard Biesheuvel <ardb+git@google.com>, linux-kernel@vger.kernel.org,
 linux-efi@vger.kernel.org, x86@kernel.org, mingo@kernel.org,
 Dionna Amalie Glaze <dionnaglaze@google.com>,
 Kevin Loughlin <kevinloughlin@google.com>
Subject: Re: [PATCH v5 3/6] x86/sev: Split off startup code from core code
User-Agent: K-9 Mail for Android
In-Reply-To: <CAMj1kXGDyM-W1umDsBGO17+UqczhODBcb73StPELfOAQN2_V2A@mail.gmail.com>
References: <20250418141253.2601348-8-ardb+git@google.com> <20250418141253.2601348-11-ardb+git@google.com> <cf878810-81ed-3017-52c6-ce6aa41b5f01@amd.com> <CAMj1kXGDyM-W1umDsBGO17+UqczhODBcb73StPELfOAQN2_V2A@mail.gmail.com>
Message-ID: <C8291B70-FC38-43DF-B0DE-EF20DA769ABA@alien8.de>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On April 23, 2025 6:50:00 PM GMT+03:00, Ard Biesheuvel <ardb@kernel=2Eorg> =
wrote:
>On Wed, 23 Apr 2025 at 17:22, Tom Lendacky <thomas=2Elendacky@amd=2Ecom> =
wrote:
>>
>> On 4/18/25 09:12, Ard Biesheuvel wrote:
>> > From: Ard Biesheuvel <ardb@kernel=2Eorg>
>> >
>> > Disentangle the SEV core code and the SEV code that is called during
>> > early boot=2E The latter piece will be moved into startup/ in a subse=
quent
>> > patch=2E
>> >
>> > Signed-off-by: Ard Biesheuvel <ardb@kernel=2Eorg>
>>
>> This patch breaks SNP guests=2E The SNP guest boots, but no longer has
>> access to the VMPCK keys needed to communicate with the ASP, which is
>> used, for example, to obtain an attestation report=2E
>>
>> It looks like the secrets_pa is defined as static in both startup=2Ec a=
nd
>> core=2Ec=2E It is set by a function in startup=2Ec and so when used in =
core=2Ec
>> its value will be 0=2E
>>
>> The following fixed the issue for me=2E Let me know if it can be squash=
ed
>> in or a full patch is needed=2E Although, it likely should be named
>> sev_secrets_pa since it is no longer static=2E
>>
>
>Thanks for the fix, and apologies for using you as a guinea pig - I've
>been struggling to get access to SEV-SNP capable hardware, although a
>suitable EPYC based machine should be arriving in a month or 2=2E
>
>I'd assume a proper patch is better, and renaming it to sev_secrets_pa
>doesn't seem that intrusive=2E But it is ultimately Ingo's call=2E

Those patches should be applied *after* they have been tested=2E mingo kno=
ws that but does it anyway=2E :-(

This rushed patch application and hurried testing and sticking fixes ontop=
 is completely counterproductive and annoying=2E

--=20
Sent from a small device: formatting sucks and brevity is inevitable=2E 

