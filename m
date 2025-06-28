Return-Path: <linux-efi+bounces-4044-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A9B4BAEC81C
	for <lists+linux-efi@lfdr.de>; Sat, 28 Jun 2025 17:04:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03D3D1BC08A2
	for <lists+linux-efi@lfdr.de>; Sat, 28 Jun 2025 15:04:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3127E21D584;
	Sat, 28 Jun 2025 15:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="D8Ja3cqW"
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6113720125F
	for <linux-efi@vger.kernel.org>; Sat, 28 Jun 2025 15:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751123028; cv=none; b=Ljfz9xbVVAbXNWa+sbdnLOmqKUH6z49c9Sw9Vu4HIL/dBrc6I5sld9+boB8ZQIFVgzyCSPiO/HyqjnF0xzHF3JDsuuuW6yEOd1QOYF2NzdfYw3I0JGAmkgdYf0uRZorLDwqDaVoD0zi2h8pE7jQ5MRet7w5ilYTUOc8//H04g68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751123028; c=relaxed/simple;
	bh=9ZaYjkfAVE3FPlngX5oiDDJMbHGyV6hblS4UA9vmZjs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sc7Gw2FYZHiPwQ/Yecyfz8D2HcPA7YNCze6pHh7+hbO0mvCcxHp0qrlPy22e8ulVwHrY4TKuJaB7phLtOREDkDHn8+dL6eQURrmAeflDkN+fjzOKlwrgbcPFpQieAW2OePTMRINCExk3lFlPkzyysbiMAFR8qCklm5PQEvtr1cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=D8Ja3cqW; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55S6uFk6002609
	for <linux-efi@vger.kernel.org>; Sat, 28 Jun 2025 15:03:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=xqTnJowqwZlwhCR/o2bpgVqV
	sVhjsA/GLdTuLcpD2JM=; b=D8Ja3cqWPMp98+fkVTOK0iM/7Bue3sYWcaujTilP
	kJ/3u5FYXxUSTPGMXZZMaHgX/lgusYFtXfmpvHZZnzzUO9eLX7qPx4svNWMQBrCE
	jfEvGBYOnpCo7tZEDF5kexkExXgHOt5O4cgL40j5dsDpLHdiFU8NmNPKOC9x5iMK
	TEaFlgebFaPh9ERwsJGaYeMc3G5jFd3+Bp5cIIrYqnXMgubKogGhD2SiF5kH7nAi
	6pJeZdX1miHKh5eAL0Hj7wyq4t7YryTFASHs058T/z0/QyPDQaozZ8AktvVotEfj
	HK0O168nnqkm2emOTrgLD9/ylNNhmZMe0yj3o2YzjkGAJg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47j7qm0u57-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-efi@vger.kernel.org>; Sat, 28 Jun 2025 15:03:44 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7d097fd7b32so216134585a.2
        for <linux-efi@vger.kernel.org>; Sat, 28 Jun 2025 08:03:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751123024; x=1751727824;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xqTnJowqwZlwhCR/o2bpgVqVsVhjsA/GLdTuLcpD2JM=;
        b=dBwYvH/BN08Ze4L2K3M/GykVPnZ7Dps5hx/JrUA6DOSC8De+1G5gjFXLS1l4xB/mK6
         D0Kn/WpO+xsaVE39dERf2y1DXBKv1xc48TY2d/LzXkOy45aFYlQgtm33xKC9QDxzXxTm
         hl0fuSwD6ThBwpt9n7mrUoyVMWxioLXIVRuwKyXyaBSy3THrBkyTcLlGnLgBhYoZD/oy
         nueKTXiPQzWsKizGj2jrJ3uaoY/4CZJf6VV3b5D6ZTovku3C/1Dalwb89bLmwB8t6LJ6
         hCvtz5qBMNhEvbX4BFG/d2BpKnxBKbAExrnrCCxx2ugd96dFj5XKOffvFc7Tz4prUzIR
         sJpA==
X-Forwarded-Encrypted: i=1; AJvYcCUebkmtSf7vYt0OD7WJDxzZ1A0nrCCOH+Ndy6drH3H2JvF5VYxqKaqLIHZDza7req+lVBNraYj3+WI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyp3g45+dT4mHqfFDYj8wYBfck+JaEEn53Xnbfe9lam1qyg3Ty/
	SBi7hKyaOS0xJnWpklfKuw5ASwL7wOYiehXL10cfC8zFFhloAalFsiT8bc3fYrsU4vy1RZMFetL
	Hs09CFclCAlZwIZJvkzug1GndAHcxY5ItTlstLANTninXaxCLuCySccJj5XyM6tI=
X-Gm-Gg: ASbGnct2RQhJRXPI2st0/Twwrq0BxKk9kFmX2eAgRlJrgIlEQIINd5MOco7UGxaTCsQ
	ytIQRE//aQ/VSiG4aAEEIqVu4vgAmJCv0hnlGhy5LFwYystomBZaRuMFJnwER2OlTJ3jgkyAxFC
	Pyup3jUPrLbq98SYK2cVHhj8SVrYvOAPjlk4YL30hrDBnqvgbSdgPt3QFlCv0I8CiPNUUwjPmT6
	X3mlSAY0sqvyV/sLum66AtTxnipUCmASWatsHJKSL1Cx7U36kArpYvdBTYl1duYRBeJuMEsLHR3
	SSDiQN3S1j8l7VDGq4tSaAwjJnnORo+VMmh363ZCsUzCXD6YW6w0/ZBhhtMQWiZMW6WTg2JSNwh
	2EQ43rypn1Qq+3MYHhTDT9gitlpSE4vAVJas=
X-Received: by 2002:a05:620a:6983:b0:7d3:d53b:35cd with SMTP id af79cd13be357-7d4439806f5mr1050278585a.40.1751123023908;
        Sat, 28 Jun 2025 08:03:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGfO4TB+7Z46znGl0aUe2Imd6wWNuSoz55SF/Y6iEWVjGqIkJQKxpsG/BhaTNLU7xneYus/eg==
X-Received: by 2002:a05:620a:6983:b0:7d3:d53b:35cd with SMTP id af79cd13be357-7d4439806f5mr1050274585a.40.1751123023434;
        Sat, 28 Jun 2025 08:03:43 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-32cd2ec6370sm8213641fa.59.2025.06.28.08.03.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Jun 2025 08:03:42 -0700 (PDT)
Date: Sat, 28 Jun 2025 18:03:40 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Johan Hovold <johan@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
        Steev Klimaszewski <steev@kali.org>, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-efi@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH v4 6/8] firmware: qcom: scm: add modparam to control
 QSEECOM enablement
Message-ID: <7jjxjkk6qwym2mt6xp7t2t4wckyrvwaj2ydubkimnx2oybitab@u4nhj5mib64l>
References: <20250625-more-qseecom-v4-0-aacca9306cee@oss.qualcomm.com>
 <20250625-more-qseecom-v4-6-aacca9306cee@oss.qualcomm.com>
 <aF0cyOpkjUI4R3bv@hovoldconsulting.com>
 <gqoba4uu62sh4qxapqkhlufxnliatevnsqcxvijvb74tposf2b@iyonh347aext>
 <aF1EDMsw1KQTlteX@hovoldconsulting.com>
 <cjinqyqn7qgvdoltoywxa2lq6bjyfrotmon3iv24tqt3bpdlpe@3xb2k42ffegj>
 <aF6Srse7BhDJkQiH@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aF6Srse7BhDJkQiH@hovoldconsulting.com>
X-Authority-Analysis: v=2.4 cv=C4TpyRP+ c=1 sm=1 tr=0 ts=68600450 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6IFa9wvqVegA:10 a=KKAkSRfTAAAA:8 a=GPfsrgj4I8Os2nzgvcMA:9 a=CjuIK1q_8ugA:10
 a=PEH46H7Ffwr30OY-TuGO:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: axazzj2c-k2jvGJJGHdnrpOSPC2XX0jq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI4MDEyNSBTYWx0ZWRfX2uw7AJj3E0Y/
 cLLguvylOIxSA7RQwsWWrZWOEYo0kYD8/p9JaCiD9ZdzzQtKovfH3nsLzaZhFM0Z2eH+pECGLEV
 SD55KU/aGQjj0WDBUduH90v4CwBnGY9z7n/V+pE6/Fcdz+yOUm9rL6bUwgAShI5sGmsWuofHy1V
 7PqLW9hBuRS1smVrEVfDwYaoqYLvaXSjFziiZnDqO/cqgMf7DoHWpxiY/plZCk1+bTni33dlbm6
 QK37wvVdf4tsDHmITjtw4OqpB3msN7XkLgduaqlkM1K5BTCU3SSot/XdFMIxMVDkiST0zvgfvuo
 Zu7jbFdAYO0ktxsJTpunv5BmHQTPdDhUhwM2RZA1/kpwt5FbFx1RD+GYYvh9uY2x66a2WyVdMMt
 lFOYZe1/slxT1/mqUY+cwgwj3AkQQfanY/UuiEgx3fahyAuhhl39Ra1POSCJ/hsNcctQxguU
X-Proofpoint-GUID: axazzj2c-k2jvGJJGHdnrpOSPC2XX0jq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-27_05,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0
 clxscore=1015 priorityscore=1501 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506280125

On Fri, Jun 27, 2025 at 02:46:38PM +0200, Johan Hovold wrote:
> On Fri, Jun 27, 2025 at 02:33:27AM +0300, Dmitry Baryshkov wrote:
> > On Thu, Jun 26, 2025 at 02:58:52PM +0200, Johan Hovold wrote:
> > > On Thu, Jun 26, 2025 at 02:08:23PM +0300, Dmitry Baryshkov wrote:
> > > > On Thu, Jun 26, 2025 at 12:11:20PM +0200, Johan Hovold wrote:
> > > > > On Wed, Jun 25, 2025 at 01:53:25AM +0300, Dmitry Baryshkov wrote:
> > > > > > From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > > > > > 
> > > > > > In preparation to enabling QSEECOM for the platforms rather than
> > > > > > individual machines provide a mechanism for the user to override default
> > > > > > selection. Allow users to use qcom_scm.qseecom modparam.
> > > > > > 
> > > > > > Setting it to 'force' will enable QSEECOM even if it disabled or not
> > > > > > handled by the allowlist.
> > > > > > 
> > > > > > Setting it to 'off' will forcibly disable the QSEECOM interface,
> > > > > > allowing incompatible machines to function.
> > > > > > 
> > > > > > Setting it to 'roefivars' will enable the QSEECOM interface, making UEFI
> > > > > > variables read-only.
> > > > > > 
> > > > > > All other values mean 'auto', trusting the allowlist in the module.
> > > > > 
> > > > > I don't see the need for this. The kernel should just provide sensible
> > > > > defaults.
> > > > 
> > > > It does provide _defaults_. However with the next commit we mass-enable
> > > > QSEECOM for SoC families, which includes untested WoA devices. If the
> > > > user observes a misbehaviour of the UEFI vars or any other
> > > > QSEECOM-related driver on those platforms, it is much easier to let
> > > > users test and workaround UEFI misbehaviour.
> > > 
> > > You basically know by now which machines supports qseecom and which do
> > > not, right (e.g. UFS storage means non-persistent EFI vars)?
> 
> Do you have a theory about why on some platforms, like the one you're
> currently adding support for, writing UEFI variables does not work?
> 
> Can you please include that information in the series so we can consider
> alternate routes for replacing the current whitelist with this black and
> white thing you're going for.
> 
> Is it related to UFS at all, for example?

Strictly speaking I have no confirmation (yet), but there are two
theories:

- UFS vs SPI-NOR
- a edk2 PCD which controls whether SetVariable commits immediately or
  whether it just buffers data until EBS (or other call).

> 
> > > And it's a pretty bad user experience to have people trying to write
> > > efivariables when setting up a machine and then spend hours trying to
> > > debug why they don't persist after a reboot.
> > > 
> > > I don't think that's fair to users.
> > 
> > So, is it a user or a developer, trying to port Linux to a new hardware?
> > Also, R/O implementation makes it obvious, that the variables do not
> > persist.
> 
> A developer enabling support for a new platform can patch the driver and
> does not need a command line option.

Yes. But it's easier to debug things this way. Consider all ACPI-related
or UEFI-related kernel options that we have.

> 
> If you enable it by default, suddenly a bunch of end-users are going to
> have to debug why storing efi variables silently fails. That would not
> be fair to them.

I'm enabling this only for platforms where all existing devices are
listed in the current whitelist.

> 
> > > Let whoever brings up a new machine figure this out. It's just one
> > > entry, no scaling issues, and we get accurate information (unless
> > > Qualcomm, who sits on the documentation, is willing to provide it
> > > upfront).
> > 
> > And that's not really scallable. All other parts of a particular device
> > are described by the DT only (that's especially true on the PMIC GLINK
> > machines). If we are to support new laptop in e.g. distro kernel, we
> > need to provide a DT... and a patch for qcom-scm driver. I'd very much
> > prefer to do it other way around: provide a DT and patch qcom-scm if the
> > laptop is any way different from other laptops. E.g. we know that all
> > X1Elite laptops support R/W EFI variables.
> 
> But this is just kicking the can and putting the burden on someone else.
> Now a user or distro would need to pass command line parameters after
> spending time debugging why efi variable updates do not persist after a
> reboot.

The original developer for new DTS will have to do that anyway, if
something fails. And once it is done, we can add a quirk for that pure
platform. However the majority of the case can go without extra quirks.
As you can see, all X-Elite / X-Plus and majority of SC8280XP platforms
already are in the whitelist. Once we sort out SC8280XP-CRD issue, all
SC8280XP platforms supported upstream will have an entry in the
allowlist, which means we can convert them to the wildcard + quirks.

> If we know with reasonable certainty that all, say X1E, devices works,
> then that that's one thing.

Yes, we do. You can hand-compare the lists too (I did).

> But if this series now enables broken EFI variable support on every
> other device then I don't think that's ok (even if you provide a command
> line parameter that each user now have to pass).
> 
> Then I'd rather see a proposal for how to determine which machines
> support this or not, information which was not available when this
> interface was reverse engineered and where a conservative whitelist
> approach made perfect sense.

WIP

> 
> > Except for X1-CRD, which deserves an entry in the driver.
> 
> I think you meant my sc8280xp CRD here.

Yes.

> 
> Johan

-- 
With best wishes
Dmitry

