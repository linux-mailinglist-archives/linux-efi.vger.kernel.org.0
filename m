Return-Path: <linux-efi+bounces-4070-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D16CAEF62B
	for <lists+linux-efi@lfdr.de>; Tue,  1 Jul 2025 13:11:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6E773A8E3C
	for <lists+linux-efi@lfdr.de>; Tue,  1 Jul 2025 11:10:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11EFE2727FB;
	Tue,  1 Jul 2025 11:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="W2x0jLM3"
X-Original-To: linux-efi@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A8482727EE
	for <linux-efi@vger.kernel.org>; Tue,  1 Jul 2025 11:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751368257; cv=none; b=BHM+n+tiy7EaLy6oIMhsTI4In40Rdi8fwIHTs7tN3+uY/F9pcH4VYCI7aQzkE8otcnQai5AwgtdvkpsLrZF5ACYMN2D2SC240B/mgMbzgz0GsYrQBoFAKeEC/I0QOH85oPOyy03hl4LVpHuoxWyGmXsRWbcwPjqnuYnuNM6h5EE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751368257; c=relaxed/simple;
	bh=ebaxhitP2XeVANtdKB9VsXlAR1GQ9/EdwbydMSQkTJQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=biIbtLRJJnjDMwrx07ogVysrarE8GJCrMkS2hCyXTC+p9foqSFA1MtX/ndMhcjQ1ZG06QM6sVlTsl0A8tPZsqlS6r0yPAdBlwOEHaxukQYQA8jrNUhD+IkXSq1CpfSzvhqszLHkNACX51Q3UfN/FI8oKP4koEolMiLFF0oySWPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=W2x0jLM3; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 561ABuRY018548
	for <linux-efi@vger.kernel.org>; Tue, 1 Jul 2025 11:10:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=7qvvoXd4DPAxwNrTX/Jr5xFg
	T9bOG00iDZW2UQY6+3Y=; b=W2x0jLM3DxykSK/5hjk4MhM3QPAper60yEKWJ1kM
	Ozxy2/iLUnwDtqIxErPu02urASGpkhYAC3cb3PzsMwrsYHiFZybeStqqp9OKr0py
	t0YkaKAvW4eWoCGLWnyHuROfZr9bzfXeLSW4DLoxr21hB56U5qlpS87+tDghy3Nv
	pEPmRsifO2JVmnHnLjuYvSVDVvp7CY86heradc6aU7bKQkr1c4H8CIvYp3jXsxgi
	FBg0zKQsD1B6JGZTVyUmDJ3DbA3iBtp4GKQ2PU2Fo57dzUYxFYAJxjJG4/t5svuu
	+/G3YRCFJaNsOS25FQfk9381/x/t2E9rHBpYA29cyrMPrg==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47j8fxgp2d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-efi@vger.kernel.org>; Tue, 01 Jul 2025 11:10:54 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7d3d3f64739so746134685a.0
        for <linux-efi@vger.kernel.org>; Tue, 01 Jul 2025 04:10:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751368253; x=1751973053;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7qvvoXd4DPAxwNrTX/Jr5xFgT9bOG00iDZW2UQY6+3Y=;
        b=HVA+5tNRk0s3v2zFwfPC6A7Pa9UJmbDQCopreuH1TvyvDKqs7z+FXHHnm1FCjfkO6f
         mSD4LM7+azyWX5TbD4ny79JbsrBWbyPaRiKwY+jJ7NPMVAZUlb63PRbyLPdo3j6Bi5qI
         i7CqVA2nXpUIHLYsnPeQuKjf57lBNpXaUzEHFlXNGpMp1CQudzCiZHX+Hcid1hndXPTh
         /N6c5iXrCx8OZEnuqnEarXasMLg/4cSSgrTCp5emGb37S/XsNtspIDmseSFx/PZ47+LI
         6jiQNvtqzTUx3b9pejQJR5KtMqdlUtUh5vIgeItMq6HTGzWI2fRLtclGi6q+j3BgKl53
         hmsg==
X-Forwarded-Encrypted: i=1; AJvYcCWeS2ITENCcsCG1aRXRvAkrDYT5Xs1GlFIyy00jYliajWUIm15BVONrNqx97wdf0QhT07YtPrIhNwc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcHaUz0y1YoWY/ZoZFkGxpV742Q7L+zpbp1zxas+iFUQhMlwmB
	GSRXxAcPV4L9gOAkBM+NkjMifBvBa4jBHnUnkWZuWAUoqSx3lAzGAYCs375+b49YbDb8MWj0nPp
	xI3uxz81t62QgMAKryDpKWUikFeEhzB8B4CznDV16dvbHgBzwhHmpKWQbJPlfZPc=
X-Gm-Gg: ASbGncsEmk8Jznu5ZVo0q5EDe9Y6F94iZZZ2m3WRtasSJW7lJ2YW/UQhCeOUH2Bu9O3
	Z5Z3sPT3hesMP1yPIbp8hNa82B4xHdT7zdpdit5lff6IdHXsL5SqmE0YDHg7c1jHS1HASnTSSGp
	/vGloh0p64gfFJXCwdnH7PDbaB9JPmdwH6C9hl3ReCDRPYTCayHeSRdPKo29Bq7WyV18IW5CW3V
	UxxnyEf8ZTFQTFzvPmjORmYZHSVhKNldVoRfVfx6pn/czDr4sAZq1qDoUfrthOatPRU2VTMYMga
	f3yQsJnBMeZHKHEq3b6LdEXbBsuzUxCamISRstZ4pQp7rY/e41Dz/QdftzlWTfk5JJdtOu4tZnV
	0JuC5Uq2CbHXZihQqIJUHrR4k1uUehgRWx0o=
X-Received: by 2002:a05:620a:1987:b0:7d0:a243:d5c5 with SMTP id af79cd13be357-7d44390231dmr2382167585a.5.1751368253056;
        Tue, 01 Jul 2025 04:10:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHnmqd3sa9HszIT11UEJ1cWsY3O4ly328cLugwQlVpIW+NiV7VChgwpnSLRwLj6H1ZXlNv/UQ==
X-Received: by 2002:a05:620a:1987:b0:7d0:a243:d5c5 with SMTP id af79cd13be357-7d44390231dmr2382162285a.5.1751368252459;
        Tue, 01 Jul 2025 04:10:52 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5550b255a51sm1800139e87.88.2025.07.01.04.10.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 04:10:51 -0700 (PDT)
Date: Tue, 1 Jul 2025 14:10:49 +0300
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
Message-ID: <af553qttxd6tqkypokqkgki3dceatsbqfw5botjrcesvg22nyr@zogoseo3j7hc>
References: <20250625-more-qseecom-v4-0-aacca9306cee@oss.qualcomm.com>
 <20250625-more-qseecom-v4-6-aacca9306cee@oss.qualcomm.com>
 <aF0cyOpkjUI4R3bv@hovoldconsulting.com>
 <gqoba4uu62sh4qxapqkhlufxnliatevnsqcxvijvb74tposf2b@iyonh347aext>
 <aF1EDMsw1KQTlteX@hovoldconsulting.com>
 <cjinqyqn7qgvdoltoywxa2lq6bjyfrotmon3iv24tqt3bpdlpe@3xb2k42ffegj>
 <aF6Srse7BhDJkQiH@hovoldconsulting.com>
 <7jjxjkk6qwym2mt6xp7t2t4wckyrvwaj2ydubkimnx2oybitab@u4nhj5mib64l>
 <aGKGHvDzlKrBDrjN@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aGKGHvDzlKrBDrjN@hovoldconsulting.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAxMDA2OCBTYWx0ZWRfX7nWwlgrR6REa
 CJkljqg5dtEe9w0MDdCZzPqOR6+Qoivdq3EeKuT7R+ZE/SUF28xVInA17/caJpmsAIe2y9tNzse
 Tv5z5AV+avGtTeDLo68zj4y6r7+R/vtSgp17X0Sk0aKFmcCT2edIivB+SsbINdbioAnmUP10896
 Ed4t1aCm9PwukOvWy084katqkzgHQw23SDUrTiqpJKjqX2JjbvzvOoEgPBURLQLtl6Kha1Na0RA
 KSDLOJ1VATlf70jRaBfSRVk/YQ26ObFJpwtKKuVQUqi3VhPx13cOPwHy4b3fGXiRdqvjsBWRgmH
 H2xa+vMVjXCBIjHcyzfY4VRq3+HrJRzDmpzO8Eo6cA93rwSo3sFOxhoVSxp9VURUOO32QyrC2/Q
 zgsUPkCYSbKkPh2kg5udyt82ZlnR1cj9U5fTQZbrTRVyu8uXVIFPd+GeR5jBssfad686VRJU
X-Proofpoint-GUID: f4eOMpKUH2pICDCtUICD_A2bmzy0NYC3
X-Proofpoint-ORIG-GUID: f4eOMpKUH2pICDCtUICD_A2bmzy0NYC3
X-Authority-Analysis: v=2.4 cv=TqPmhCXh c=1 sm=1 tr=0 ts=6863c23e cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Wb1JkmetP80A:10 a=JjxlrjXdNPBxzYv9-tkA:9 a=CjuIK1q_8ugA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-01_02,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 phishscore=0 malwarescore=0 clxscore=1015 lowpriorityscore=0 mlxscore=0
 impostorscore=0 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507010068

On Mon, Jun 30, 2025 at 02:42:06PM +0200, Johan Hovold wrote:
> On Sat, Jun 28, 2025 at 06:03:40PM +0300, Dmitry Baryshkov wrote:
> > On Fri, Jun 27, 2025 at 02:46:38PM +0200, Johan Hovold wrote:
> > > On Fri, Jun 27, 2025 at 02:33:27AM +0300, Dmitry Baryshkov wrote:
> > > > On Thu, Jun 26, 2025 at 02:58:52PM +0200, Johan Hovold wrote:
> > > > > On Thu, Jun 26, 2025 at 02:08:23PM +0300, Dmitry Baryshkov wrote:
> > > > > > On Thu, Jun 26, 2025 at 12:11:20PM +0200, Johan Hovold wrote:
> 
> > > > > You basically know by now which machines supports qseecom and which do
> > > > > not, right (e.g. UFS storage means non-persistent EFI vars)?
> > > 
> > > Do you have a theory about why on some platforms, like the one you're
> > > currently adding support for, writing UEFI variables does not work?
> > > 
> > > Can you please include that information in the series so we can consider
> > > alternate routes for replacing the current whitelist with this black and
> > > white thing you're going for.
> > > 
> > > Is it related to UFS at all, for example?
> > 
> > Strictly speaking I have no confirmation (yet), but there are two
> > theories:
> > 
> > - UFS vs SPI-NOR
> 
> Someone with time and the sc8280xp and x1e CRDs should be able to set
> them up for booting from either UFS or SPI-NOR and see if that makes a
> difference to confirm this.
> 
> So far my sc8280xp CRD with UFS fails, while Konrad's work with SPI-NOR
> (NVMe).
> 
> My x1e CRD works but also boots from SPI-NOR (NVMe).
> 
> The Yoga C630 booting from UFS is also known to fail.
> 
> > - a edk2 PCD which controls whether SetVariable commits immediately or
> >   whether it just buffers data until EBS (or other call).
> > 
> > > 
> > > > > And it's a pretty bad user experience to have people trying to write
> > > > > efivariables when setting up a machine and then spend hours trying to
> > > > > debug why they don't persist after a reboot.
> > > > > 
> > > > > I don't think that's fair to users.
> > > > 
> > > > So, is it a user or a developer, trying to port Linux to a new hardware?
> > > > Also, R/O implementation makes it obvious, that the variables do not
> > > > persist.
> > > 
> > > A developer enabling support for a new platform can patch the driver and
> > > does not need a command line option.
> > 
> > Yes. But it's easier to debug things this way. Consider all ACPI-related
> > or UEFI-related kernel options that we have.
> 
> That's because there is a common kernel implementation used across a
> host of fw implementations.
> 
> Here it's just Qualcomm doing something funny that affects their own
> platforms. We should be able to figure this out without forcing users or
> distros to pass command line parameters.

This is not intended for the normal working course, but for the initial
bringup / nailing out issues after the bringup (e.g. after firmware
upgrade).

> 
> > > If you enable it by default, suddenly a bunch of end-users are going to
> > > have to debug why storing efi variables silently fails. That would not
> > > be fair to them.
> > 
> > I'm enabling this only for platforms where all existing devices are
> > listed in the current whitelist.
> 
> Do we know if there are any sc8280xp or x1e machines that boot off UFS?
> 
> If not (even with the exception of the CRDs) then it should be fine to
> just whitelist the SoCs without any command line parameters.

I'm not aware of such platforms.

> 
> > > > > Let whoever brings up a new machine figure this out. It's just one
> > > > > entry, no scaling issues, and we get accurate information (unless
> > > > > Qualcomm, who sits on the documentation, is willing to provide it
> > > > > upfront).
> > > > 
> > > > And that's not really scallable. All other parts of a particular device
> > > > are described by the DT only (that's especially true on the PMIC GLINK
> > > > machines). If we are to support new laptop in e.g. distro kernel, we
> > > > need to provide a DT... and a patch for qcom-scm driver. I'd very much
> > > > prefer to do it other way around: provide a DT and patch qcom-scm if the
> > > > laptop is any way different from other laptops. E.g. we know that all
> > > > X1Elite laptops support R/W EFI variables.
> > > 
> > > But this is just kicking the can and putting the burden on someone else.
> > > Now a user or distro would need to pass command line parameters after
> > > spending time debugging why efi variable updates do not persist after a
> > > reboot.
> > 
> > The original developer for new DTS will have to do that anyway, if
> > something fails. And once it is done, we can add a quirk for that pure
> > platform. However the majority of the case can go without extra quirks.
> 
> Adding to a blacklist is bound to be overlooked, while adding to a
> whitelist is not.

You can't overlook it since it is required as a part of almost any
distro setup - point UEFI boot sequence to your new bootloader entry.

> 
> > As you can see, all X-Elite / X-Plus and majority of SC8280XP platforms
> > already are in the whitelist. Once we sort out SC8280XP-CRD issue, all
> > SC8280XP platforms supported upstream will have an entry in the
> > allowlist, which means we can convert them to the wildcard + quirks.
> 
> I'd rather see you get to the bottom of the UFS boot issue and whether
> there is some way to determine this programmatically.

I don't see a good way to do that - UFS might be probed very late, it
might be unused for the boot at all, etc.

> 
> > > If we know with reasonable certainty that all, say X1E, devices works,
> > > then that that's one thing.
> > 
> > Yes, we do. You can hand-compare the lists too (I did).
> 
> If everything that's currently upstream boots from NVMe that may not
> necessarily mean it works for devices using UFS.

And? I don't care that much about theoretical devices here.

> 
> > > But if this series now enables broken EFI variable support on every
> > > other device then I don't think that's ok (even if you provide a command
> > > line parameter that each user now have to pass).
> > > 
> > > Then I'd rather see a proposal for how to determine which machines
> > > support this or not, information which was not available when this
> > > interface was reverse engineered and where a conservative whitelist
> > > approach made perfect sense.
> > 
> > WIP
> 
> Good. We can manage with adding new entries for a while still while you
> guys at Qualcomm work this out.

You (we) guys at Linaro could have figured that out too ;-)

-- 
With best wishes
Dmitry

