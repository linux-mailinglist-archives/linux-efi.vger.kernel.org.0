Return-Path: <linux-efi+bounces-1120-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD2408D6468
	for <lists+linux-efi@lfdr.de>; Fri, 31 May 2024 16:23:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 09BFAB21D5A
	for <lists+linux-efi@lfdr.de>; Fri, 31 May 2024 14:22:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E16861864C;
	Fri, 31 May 2024 14:22:23 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from out03.mta.xmission.com (out03.mta.xmission.com [166.70.13.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34E14179AE;
	Fri, 31 May 2024 14:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.70.13.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717165343; cv=none; b=Oh5BDAy4hUwwQpd88Om8T5fsNswmSb6EnBBI3MHEODXqiR+jRvoZ9KlFSjr4Rh3dB8v8Yat/JBPcAxTJ7pPZB1szCC4/SazJTksCm8jMnkeSMollGeDUPfzclvGi7tb3zMBYkqub+R81ELX0s8sYqY0nI8NhIY3gaVIrpjqaqGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717165343; c=relaxed/simple;
	bh=KhPwAHj5psCQsqX4Dn8+N9prZw+SckfJvkJ/770euJo=;
	h=From:To:Cc:References:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type:Subject; b=NGMsXDK+eMpNdQz83jggdYNlO1APeUCjdyuZwDiCK9k0BkYVBuGfu2JLjYsdozmPT581zes2gTl1n0Ubn2jDFVf9ZaOksXVHOXNJ2v2xQmAY0RTR9mZWH3uIXqLcPjoZEu0BMe8icY4uWi/FYEQWTHuplNQOQPIQSaz4aqeIftk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com; spf=pass smtp.mailfrom=xmission.com; arc=none smtp.client-ip=166.70.13.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xmission.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xmission.com
Received: from in01.mta.xmission.com ([166.70.13.51]:42770)
	by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1sD2jp-003KCz-6R; Fri, 31 May 2024 07:56:09 -0600
Received: from ip68-227-168-167.om.om.cox.net ([68.227.168.167]:39510 helo=email.froward.int.ebiederm.org.xmission.com)
	by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1sD2jo-00Bi30-2x; Fri, 31 May 2024 07:56:08 -0600
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: Eric Biggers <ebiggers@kernel.org>
Cc: Ross Philipson <ross.philipson@oracle.com>,
  linux-kernel@vger.kernel.org,  x86@kernel.org,
  linux-integrity@vger.kernel.org,  linux-doc@vger.kernel.org,
  linux-crypto@vger.kernel.org,  kexec@lists.infradead.org,
  linux-efi@vger.kernel.org,  iommu@lists.linux-foundation.org,
  dpsmith@apertussolutions.com,  tglx@linutronix.de,  mingo@redhat.com,
  bp@alien8.de,  hpa@zytor.com,  dave.hansen@linux.intel.com,
  ardb@kernel.org,  mjg59@srcf.ucam.org,
  James.Bottomley@hansenpartnership.com,  peterhuewe@gmx.de,
  jarkko@kernel.org,  jgg@ziepe.ca,  luto@amacapital.net,
  nivedita@alum.mit.edu,  herbert@gondor.apana.org.au,
  davem@davemloft.net,  corbet@lwn.net,  dwmw2@infradead.org,
  baolu.lu@linux.intel.com,  kanth.ghatraju@oracle.com,
  andrew.cooper3@citrix.com,  trenchboot-devel@googlegroups.com
References: <20240531010331.134441-1-ross.philipson@oracle.com>
	<20240531010331.134441-7-ross.philipson@oracle.com>
	<20240531021656.GA1502@sol.localdomain>
Date: Fri, 31 May 2024 08:54:21 -0500
In-Reply-To: <20240531021656.GA1502@sol.localdomain> (Eric Biggers's message
	of "Thu, 30 May 2024 19:16:56 -0700")
Message-ID: <874jaegk8i.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1sD2jo-00Bi30-2x;;;mid=<874jaegk8i.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.168.167;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX19trb9vNuHauQyjgb2/8G4ddYyfaO4Rxd0=
X-SA-Exim-Connect-IP: 68.227.168.167
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Level: *
X-Spam-Report: 
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	*  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
	*      [score: 0.5000]
	*  0.7 XMSubLong Long Subject
	*  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
	* -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
	*      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
	*  0.0 T_TooManySym_01 4+ unique symbols in subject
	*  1.0 T_XMDrugObfuBody_08 obfuscated drug references
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *;Eric Biggers <ebiggers@kernel.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 465 ms - load_scoreonly_sql: 0.11 (0.0%),
	signal_user_changed: 12 (2.5%), b_tie_ro: 10 (2.1%), parse: 1.18
	(0.3%), extract_message_metadata: 15 (3.3%), get_uri_detail_list: 1.99
	(0.4%), tests_pri_-2000: 15 (3.2%), tests_pri_-1000: 3.1 (0.7%),
	tests_pri_-950: 1.25 (0.3%), tests_pri_-900: 1.09 (0.2%),
	tests_pri_-90: 77 (16.6%), check_bayes: 76 (16.3%), b_tokenize: 16
	(3.4%), b_tok_get_all: 13 (2.8%), b_comp_prob: 4.4 (0.9%),
	b_tok_touch_all: 38 (8.2%), b_finish: 1.11 (0.2%), tests_pri_0: 324
	(69.8%), check_dkim_signature: 0.77 (0.2%), check_dkim_adsp: 3.2
	(0.7%), poll_dns_idle: 0.97 (0.2%), tests_pri_10: 2.1 (0.5%),
	tests_pri_500: 8 (1.7%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH v9 06/19] x86: Add early SHA-1 support for Secure Launch
 early measurements
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)

Eric Biggers <ebiggers@kernel.org> writes:

> On Thu, May 30, 2024 at 06:03:18PM -0700, Ross Philipson wrote:
>> From: "Daniel P. Smith" <dpsmith@apertussolutions.com>
>> 
>> For better or worse, Secure Launch needs SHA-1 and SHA-256. The
>> choice of hashes used lie with the platform firmware, not with
>> software, and is often outside of the users control.
>> 
>> Even if we'd prefer to use SHA-256-only, if firmware elected to start us
>> with the SHA-1 and SHA-256 backs active, we still need SHA-1 to parse
>> the TPM event log thus far, and deliberately cap the SHA-1 PCRs in order
>> to safely use SHA-256 for everything else.
>> 
>> The SHA-1 code here has its origins in the code from the main kernel:
>> 
>> commit c4d5b9ffa31f ("crypto: sha1 - implement base layer for SHA-1")
>> 
>> A modified version of this code was introduced to the lib/crypto/sha1.c
>> to bring it in line with the SHA-256 code and allow it to be pulled into the
>> setup kernel in the same manner as SHA-256 is.
>> 
>> Signed-off-by: Daniel P. Smith <dpsmith@apertussolutions.com>
>> Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
>
> Thanks.  This explanation doesn't seem to have made it into the actual code or
> documentation.  Can you please get it into a more permanent location?
>
> Also, can you point to where the "deliberately cap the SHA-1 PCRs" thing happens
> in the code?
>
> That paragraph is also phrased as a hypothetical, "Even if we'd prefer to use
> SHA-256-only".  That implies that you do not, in fact, prefer SHA-256 only.  Is
> that the case?  Sure, maybe there are situations where you *have* to use SHA-1,
> but why would you not at least *prefer* SHA-256?

Yes.  Please prefer to use SHA-256.

Have you considered implementing I think it is SHA1-DC (as git has) that
is compatible with SHA1 but blocks the known class of attacks where
sha1 is actively broken at this point?

No offense to your Trenchboot project but my gut says that anything new
relying on SHA-1 is probably a bad joke at this point.

Firmware can most definitely be upgraded and if the goal is a more
secure boot the usual backwards compatibility concerns for supporting
old firmware really don't apply.

Perhaps hide all of the SHA-1 stuff behind CONFIG_TRENCHBOOT_PROTOTYPE
or something like that to make it clear that SHA-1 is not appropriate
for any kind of production deployment and is only good for prototyping
your implementation until properly implemented firmware comes along.

Eric

