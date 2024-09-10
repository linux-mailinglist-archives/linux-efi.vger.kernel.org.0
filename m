Return-Path: <linux-efi+bounces-1689-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 58F61972A2E
	for <lists+linux-efi@lfdr.de>; Tue, 10 Sep 2024 09:06:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 056D71F254F1
	for <lists+linux-efi@lfdr.de>; Tue, 10 Sep 2024 07:06:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 082CA17BB32;
	Tue, 10 Sep 2024 07:06:31 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from gardel.0pointer.net (gardel.0pointer.net [85.214.157.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95AC317BB1A;
	Tue, 10 Sep 2024 07:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.157.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725951990; cv=none; b=jWCPMmgXoeOEnRYK+8tcpRp6TYCcMl6lQLRcFTm17+/dTKWTz5HFfNRQSZML8nFA8eFED0RcdUwthxT+1QJdvIsfWhomGhLwDwXsiAUre6QZ5hh0OSwNjtErRxtnEVvKjiFSNKse/0j3EM0tgt6JHCvmSUUWcxTlv0VpZSnws5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725951990; c=relaxed/simple;
	bh=rCVoa3pX0ioAuE269RmGy2npE9BnrIt4dNjtAYPYgIU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f1GRQct3hjNfne/ABNF+bzrO7tq70kQTUAMP6XmX7GZgbpMZwvB02KoU/tofKaYIBg3/b1E6DZEHPJ8dZmgeHofnT5BClDfptInGPdr2Vr/eVd6VXGAiXvS2oolqtUoSae1OXP+/H+yVOlZHtbpUTUSMAp/4AL5/QWxQ5O2NVuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0pointer.de; spf=pass smtp.mailfrom=0pointer.de; arc=none smtp.client-ip=85.214.157.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0pointer.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0pointer.de
Received: from gardel-login.0pointer.net (gardel-mail [IPv6:2a01:238:43ed:c300:10c3:bcf3:3266:da74])
	by gardel.0pointer.net (Postfix) with ESMTP id 4287CE80261;
	Tue, 10 Sep 2024 09:06:25 +0200 (CEST)
Received: by gardel-login.0pointer.net (Postfix, from userid 1000)
	id 0000C160143; Tue, 10 Sep 2024 09:06:23 +0200 (CEST)
Date: Tue, 10 Sep 2024 09:06:23 +0200
From: Lennart Poettering <mzxreary@0pointer.de>
To: Pingfan Liu <piliu@redhat.com>
Cc: Ard Biesheuvel <ardb@kernel.org>, Jan Hendrik Farr <kernel@jfarr.cc>,
	Philipp Rudo <prudo@redhat.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Eric Biederman <ebiederm@xmission.com>, Baoquan He <bhe@redhat.com>,
	Dave Young <dyoung@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
	Will Deacon <will@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	kexec@lists.infradead.org, linux-efi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFCv2 0/9] UEFI emulator for kexec
Message-ID: <Zt_v7zRSsmanW89Z@gardel-login>
References: <20240819145417.23367-1-piliu@redhat.com>
 <ZsX5QNie3pzocSfT@gardel-login>
 <CAF+s44S2Ph1_nFcZYy3j0Jr4yuHayb5zdNu1YXg8ce_Lf3TOgQ@mail.gmail.com>
 <Zsb1isJ2cYRp2jpj@gardel-login>
 <CAF+s44SQtRxZz=2eSJ-xP44ORLqvq0doEQ8qrw+1RaKFhoje8w@mail.gmail.com>
 <ZsyFr8V6yizMiBTw@gardel-login>
 <CAF+s44TkqcpA9oQPy5BxV7mAx6qS+=XZ-hG86ttR8ZxFxeTzLw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAF+s44TkqcpA9oQPy5BxV7mAx6qS+=XZ-hG86ttR8ZxFxeTzLw@mail.gmail.com>

On Mo, 09.09.24 21:38, Pingfan Liu (piliu@redhat.com) wrote:

> Hi Lennart,
>
> I spent some time understanding the systemd-pcrlock and TPM stuff, and
> got some idea about it. Could you correct me if I'm wrong? Please see
> the following comments inlined.
>
> On Mon, Aug 26, 2024 at 9:40 PM Lennart Poettering <mzxreary@0pointer.de> wrote:
> >
> > On Do, 22.08.24 22:29, Pingfan Liu (piliu@redhat.com) wrote:
> >
> > > > Hmm, I'd really think about this with some priority. The measurement
> > > > stuff should not be an afterthought, it typically has major
> > > > implications on how you design your transitions, because measurements
> > > > of some component always need to happen *before* you pass control to
> > > > it, otherwise they are pointless.
> > > >
> > >
> > > At present, my emulator returns false to is_efi_secure_boot(), so
> > > systemd-stub does not care about the measurement, and moves on.
> > >
> > > Could you enlighten me about how systemd utilizes the measurement? I
> > > grepped 'TPM2_PCR_KERNEL_CONFIG', and saw the systemd-stub asks to
> > > extend PCR. But where is the value checked? I guess the systemd will
> > > hang if the check fails.
> >
> > systemd's "systemd-pcrlock" tool will look for measurements like that
> > and generate disk encryption TPM policies from that.
> >
>
> Before kexec reboots to the new kernel
> systemd-pcrlock can predict the expected PCR value and store it in the
> file system.

I's a set of PCR values pcrlock predicts, one or more for each PCR. It
then compiles a TPM "policy" from that, which is identified by a hash,
and that hash is then stored in a TPM "nvindex" (which is a bit of
memory a tpm provides).

> One thing should be noticed is that PCR value can not be affected.

Well, a kexec *should* affect some PCRs. Replacement of the kernel
*must* be visible in the measurement logs somehow, in a predictable
fashion.

> And kexec rebooting happens. systemd-stub extends the PCR value. When
> the system is up, systemd checks the real PCR value against the
> expected value rendered by systemd-pcrlock? If matching, all related
> policies succeed.

Well, it's not systemd that checks that, but the TPM. i.e. not the
untrusted OS but the the suppedly more trusted TPM.

So, key is that we want that measurements take place, the kexec
operation *must* be made visible in the measurement logs. But it must
be in a well-defined way, and ideally as an extension of the
measurements sd-stub currently makes.

(BTW, I personally don't think emulating EFI is really that
important. As long as we get the key functionality that sd-stub
provides also when doing kexec I am happy. i.e. whether it is sd-stub
that does this or some other piece of code doesn't really matter to
me. What I do care about is that we can parameterize the invoked
kernel in a similar fashion as we can parameterize sd-stub, and that
the measurements applied are also equivalent.)

Lennart

--
Lennart Poettering, Berlin

