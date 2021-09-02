Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D02CA3FEF8D
	for <lists+linux-efi@lfdr.de>; Thu,  2 Sep 2021 16:37:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345620AbhIBOiY (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 2 Sep 2021 10:38:24 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:61562 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1345384AbhIBOiX (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 2 Sep 2021 10:38:23 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 182EaOXo165236;
        Thu, 2 Sep 2021 10:36:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : reply-to : to : cc : date : in-reply-to : references : content-type
 : mime-version : content-transfer-encoding; s=pp1;
 bh=QQOx2dSPxDVAXueWM26ZKrTyuuWFHbOcZuKe0GxBDqc=;
 b=lXe6mpMY1RSgVZiN+/t0QYXE7+GVP7HYxEavQmupFDFcYlAc2mcinNYtLKwgimP4GT/s
 xAVMeNZ7r56BoiXMCVUdKcGPxj/JgvAHbIqEKvlPBZ+c2CYuwBbGsuXPspzbCHszNEON
 U2kZQ1o0axMpxgZSGPl1hy2dFvCYOTULatqIPpIBGY+8LKSslWO44G3l/ofYwf+gLndQ
 jh8po++74rQPHl/00cWBUHk5ReFqSlUoL5rpWC1/bboMJkcak1lRhkfrqYqvKAP4/fXA
 X6AL71NknFnflYh8uaDJPkw47HSUNuD6ty5yv/9EXvlYx5ydIi9otUZtanTnCQfYTwBm 1g== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3atx7s4n7t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 02 Sep 2021 10:36:58 -0400
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 182Eamt9176030;
        Thu, 2 Sep 2021 10:36:50 -0400
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3atx7s4kv0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 02 Sep 2021 10:36:50 -0400
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 182EX1AY009907;
        Thu, 2 Sep 2021 14:35:15 GMT
Received: from b03cxnp07027.gho.boulder.ibm.com (b03cxnp07027.gho.boulder.ibm.com [9.17.130.14])
        by ppma01wdc.us.ibm.com with ESMTP id 3atdxcw61g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 02 Sep 2021 14:35:15 +0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp07027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 182EZDpb22544680
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 2 Sep 2021 14:35:13 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 580717805E;
        Thu,  2 Sep 2021 14:35:13 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9203C7805C;
        Thu,  2 Sep 2021 14:35:11 +0000 (GMT)
Received: from jarvis.int.hansenpartnership.com (unknown [9.211.89.117])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Thu,  2 Sep 2021 14:35:11 +0000 (GMT)
Message-ID: <e6fb1d54605690cc1877d7140fc9346c22268111.camel@linux.ibm.com>
Subject: Re: [PATCH 0/3] Allow access to confidential computing secret area
 in SEV guests
From:   James Bottomley <jejb@linux.ibm.com>
Reply-To: jejb@linux.ibm.com
To:     Greg KH <gregkh@linuxfoundation.org>,
        Dov Murik <dovmurik@linux.ibm.com>
Cc:     linux-efi@vger.kernel.org, Borislav Petkov <bp@suse.de>,
        Ashish Kalra <ashish.kalra@amd.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Andi Kleen <ak@linux.intel.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        Tobin Feldman-Fitzthum <tobin@linux.ibm.com>,
        Jim Cadden <jcadden@ibm.com>, linux-coco@lists.linux.dev,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 02 Sep 2021 07:35:10 -0700
In-Reply-To: <YTDKUe8rXrr0Zika@kroah.com>
References: <20210809190157.279332-1-dovmurik@linux.ibm.com>
         <YTDKUe8rXrr0Zika@kroah.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 2uIctKjwkKId-PZq3lXiSlKWDWRXbgD2
X-Proofpoint-GUID: nu-lMzyUK01YpvCD-ek8yGODxVmxN_Rw
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-09-02_04:2021-09-02,2021-09-02 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 mlxscore=0 bulkscore=0 adultscore=0 mlxlogscore=999
 priorityscore=1501 malwarescore=0 phishscore=0 clxscore=1011 spamscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2108310000 definitions=main-2109020086
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, 2021-09-02 at 14:57 +0200, Greg KH wrote:
[...]
> Wait, why are you using securityfs for this?
> 
> securityfs is for LSMs to use. 

No it isn't ... at least not exclusively; we use it for non LSM
security purposes as well, like for the TPM BIOS log and for IMA.  What
makes you think we should start restricting securityfs to LSMs only? 
That's not been the policy up to now.
 
>  If you want your own filesystem to play around with stuff like this,
> great, write your own, it's only 200 lines or less these days.  We
> used to do it all the time until people realized they should just use
> sysfs for driver stuff.

This is a security purpose (injected key retrieval), so securityfs
seems to be the best choice.  It's certainly possible to create a new
filesystem, but I really think things with a security purpose should
use securityfs so people know where to look for them.

James


> But this isn't a driver, so sure, add your own virtual filesystem,
> mount it somewhere and away you go, no messing around with
> securityfs, right?
> 
> thanks,
> 
> greg k-h


