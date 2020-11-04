Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A78CD2A6C96
	for <lists+linux-efi@lfdr.de>; Wed,  4 Nov 2020 19:20:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730168AbgKDSUx (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 4 Nov 2020 13:20:53 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:11134 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729488AbgKDSUx (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 4 Nov 2020 13:20:53 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0A4ICcAA022661;
        Wed, 4 Nov 2020 13:20:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=kd1//jZIZCImtWZvWXzuYeiooMNHmdvew8aCWPftKow=;
 b=CfTeVR1qYIYUzw3daBdGklYtuPyQKiGfe1w6cO4UE5yt/H2CRkocoBCAMAdaYBqUqeVT
 +LT+90imVvSGp4en7mW1Q2K0pgz87A+PoAZVWDxJ809+93fxLQoiTynrsiEWJn8WYN1b
 5tn+FyJK56R6W+zcit4/G1T210AdEt1J6+6ziBSKN0q+SfMiv4NHvOgfdzZcnSMm+vw2
 FPPhiKjDu5IaGNdGt1EYTnLjBdvpXA7iaJHfsSktZ3P4ikz4A5Re3zClkDqmMmMj91al
 SA1E4xWuii/+nClYKAQqjH97tSWiBdrmBmuqC9KDKPXCsz8MA1ja4U8AmvVRIWLcdCWO Qg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 34ktuu6sq6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 04 Nov 2020 13:20:38 -0500
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0A4ICr3n023646;
        Wed, 4 Nov 2020 13:20:38 -0500
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 34ktuu6spb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 04 Nov 2020 13:20:37 -0500
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0A4ICn3x025049;
        Wed, 4 Nov 2020 18:20:35 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma04ams.nl.ibm.com with ESMTP id 34h01uceh4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 04 Nov 2020 18:20:35 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0A4IKXaX61145510
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 4 Nov 2020 18:20:33 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 475374C04E;
        Wed,  4 Nov 2020 18:20:33 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8051C4C046;
        Wed,  4 Nov 2020 18:20:30 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.13.183])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  4 Nov 2020 18:20:30 +0000 (GMT)
Message-ID: <2fd203414ba8ac3349f0109fea633838b4e04f05.camel@linux.ibm.com>
Subject: Re: [PATCH v4 0/3] wire up IMA secure boot for arm64
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org
Cc:     jmorris@namei.org, serge@hallyn.com, dmitry.kasatkin@gmail.com,
        catalin.marinas@arm.com, will@kernel.org, clin@suse.com,
        x86@kernel.org, jlee@suse.com, linux-integrity@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Date:   Wed, 04 Nov 2020 13:20:29 -0500
In-Reply-To: <20201102223800.12181-1-ardb@kernel.org>
References: <20201102223800.12181-1-ardb@kernel.org>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-12.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-04_12:2020-11-04,2020-11-04 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 suspectscore=0
 clxscore=1015 lowpriorityscore=0 mlxlogscore=859 spamscore=0
 impostorscore=0 phishscore=0 adultscore=0 malwarescore=0
 priorityscore=1501 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2011040130
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi Ard, Chester,

On Mon, 2020-11-02 at 23:37 +0100, Ard Biesheuvel wrote:
> This is a follow-up to Chester's series [0] to enable IMA to the secure
> boot state of arm64 platforms, which is EFI based.
> 
> This v4 implements the changes I suggested to Chester, in particular:
> - disregard MokSbState when factoring out secure boot mode discovery
> - turn the x86 IMA arch code into shared code for all architectures.
> 
> This reduces the final patch to a one liner enabling a Kconfig option
> for arm64 when EFI is enabled.
> 
> Build tested only.

Thank you!  This patch set is now queued in the linux-integrity next-
integrity-testing branch.

Mimi

