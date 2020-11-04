Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 722192A6E61
	for <lists+linux-efi@lfdr.de>; Wed,  4 Nov 2020 20:56:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730730AbgKDT4I (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 4 Nov 2020 14:56:08 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:38242 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727013AbgKDT4H (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 4 Nov 2020 14:56:07 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0A4J3S0r068899;
        Wed, 4 Nov 2020 14:55:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=uKgS/lzlm/XbxcCRTAK5gYzWkuXL4bMFeZjT6XciUP4=;
 b=MphyxUBE3LEhfbJZuLjf5+wmFpuUn0F7tWZaWpD+yY459MRESqVORi77eFTutDfwzTRR
 7ybRPZFMOEhJsZqf6J4llXBoJZTrabNh+NfhDtoz0mHgW9OwOVxL8YdBcVdCj0F+cUVj
 BzD8zPhQg9qtiYwn/GTaDTRwCe+IiUSyM54zmyKWDqURULCngQZn4dwLwQujN9b//RQe
 g9uLSNXORqchflfYbKH1w3p1HIKExO8PZgT5DZGJ7Mn43h9wisYJpcCx3hLXak0S/oKs
 D21QyzW46Ml4p02UwhzrVfoA8V6O57Lx5xCJVdLGNA9c/tkX2tws+sYnptWie2QTE8wE nA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 34m1yh9mhf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 04 Nov 2020 14:55:31 -0500
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0A4J48Er073162;
        Wed, 4 Nov 2020 14:55:30 -0500
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com with ESMTP id 34m1yh9mgn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 04 Nov 2020 14:55:30 -0500
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0A4JnhgA026353;
        Wed, 4 Nov 2020 19:55:28 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma06fra.de.ibm.com with ESMTP id 34h01kjd73-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 04 Nov 2020 19:55:28 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0A4JtP4a59179370
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 4 Nov 2020 19:55:26 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E3B47A4040;
        Wed,  4 Nov 2020 19:55:25 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5AA87A4053;
        Wed,  4 Nov 2020 19:55:23 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.13.183])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  4 Nov 2020 19:55:23 +0000 (GMT)
Message-ID: <cee4fc79d7918a764b75a7bc38cd6323f4704086.camel@linux.ibm.com>
Subject: Re: [PATCH v4 0/3] wire up IMA secure boot for arm64
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Chester Lin <clin@suse.com>,
        X86 ML <x86@kernel.org>, "Lee, Chun-Yi" <jlee@suse.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Date:   Wed, 04 Nov 2020 14:55:22 -0500
In-Reply-To: <CAMj1kXFuHTruFRudKT512Cmj35KJjcJkTfeHtEjVbfCUZ6oBFQ@mail.gmail.com>
References: <20201102223800.12181-1-ardb@kernel.org>
         <2fd203414ba8ac3349f0109fea633838b4e04f05.camel@linux.ibm.com>
         <CAMj1kXEjKt0F8dZBnF=x2ShkxyvoGApXzVA-HMCY2oOj7kuKKg@mail.gmail.com>
         <c044fc25be309e7b25a4c64845fd753515c84804.camel@linux.ibm.com>
         <CAMj1kXFuHTruFRudKT512Cmj35KJjcJkTfeHtEjVbfCUZ6oBFQ@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-12.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-04_12:2020-11-04,2020-11-04 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=999
 suspectscore=0 adultscore=0 priorityscore=1501 impostorscore=0 mlxscore=0
 spamscore=0 lowpriorityscore=0 phishscore=0 malwarescore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011040138
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, 2020-11-04 at 20:12 +0100, Ard Biesheuvel wrote:

> > I do not have a problem with this patch set being upstream via EFI.
> >
> 
> Ah right. That is probably better, as EFI goes via the x86 tree, and I
> work closely with the arm64 maintainers on other things as well.
> 
> Please let me know once you are ready to ack this from IMA pov, and I
> will carry it further.

thanks,

Acked-by: Mimi Zohar <zohar@linux.ibm.com>

