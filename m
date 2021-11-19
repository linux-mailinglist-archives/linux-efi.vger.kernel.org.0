Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F67C4566EA
	for <lists+linux-efi@lfdr.de>; Fri, 19 Nov 2021 01:23:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233600AbhKSA04 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 18 Nov 2021 19:26:56 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:10130 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231190AbhKSA0z (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 18 Nov 2021 19:26:55 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AINT5cA014043;
        Fri, 19 Nov 2021 00:23:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=+Jnhh1f/VElceT/OHiIbaQ960dhQ3fZOfftYEOJvnc8=;
 b=TWxg/lalitCuGGVNrZiXCiA25uyTyGx9RFB1q7yKX6nr5zCgB2ALQa3v9iEIfcgZu3bA
 QtsxuAEYrVyn/+DcpiTLUr3sPhTGsKdt12hzoxcwtAaQ1O8d1Er3yKURJpqxFu0ZbS19
 l5bksDyFertqWQWRKp0ng/tMpBd4rjfQeWq9yV0wEaxFEh3bsDbaNFLKH+m04+I2KCkh
 19VmwCNzHkYO17guPjXoLX31XQjrBVE4OMsn5cTRYUuL4n2ZV18t/hzvUsAJ6U/yCJR/
 sT304Tr3lEQZXIxWF1OYGWbCL9mcgrfaNQXAr1Ys9PTU6IeEWLivDPRYXIDxiFXbxU5w vQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3ce0hxh7sn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 Nov 2021 00:23:36 +0000
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1AJ0KbYU024890;
        Fri, 19 Nov 2021 00:23:35 GMT
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3ce0hxh7s5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 Nov 2021 00:23:35 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1AJ0HdiU012946;
        Fri, 19 Nov 2021 00:23:33 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma06fra.de.ibm.com with ESMTP id 3ca4mks6r4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 Nov 2021 00:23:33 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1AJ0GWLr59834754
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 Nov 2021 00:16:32 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7B58C11C066;
        Fri, 19 Nov 2021 00:23:30 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1369A11C04A;
        Fri, 19 Nov 2021 00:23:27 +0000 (GMT)
Received: from sig-9-65-86-194.ibm.com (unknown [9.65.86.194])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 19 Nov 2021 00:23:26 +0000 (GMT)
Message-ID: <14efbdcd7e0c3a2585a42bfb2acd45512d55c635.camel@linux.ibm.com>
Subject: Re: [PATCH v7 12/17] KEYS: integrity: change link restriction to
 trust the machine keyring
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Eric Snowberg <eric.snowberg@oracle.com>, keyrings@vger.kernel.org,
        linux-integrity@vger.kernel.org, dhowells@redhat.com,
        dwmw2@infradead.org, herbert@gondor.apana.org.au,
        davem@davemloft.net, jarkko@kernel.org, jmorris@namei.org,
        serge@hallyn.com
Cc:     keescook@chromium.org, torvalds@linux-foundation.org,
        weiyongjun1@huawei.com, nayna@linux.ibm.com, ebiggers@google.com,
        ardb@kernel.org, nramas@linux.microsoft.com, lszubowi@redhat.com,
        jason@zx2c4.com, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-efi@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        James.Bottomley@HansenPartnership.com, pjones@redhat.com,
        konrad.wilk@oracle.com
Date:   Thu, 18 Nov 2021 19:23:26 -0500
In-Reply-To: <20211116001545.2639333-13-eric.snowberg@oracle.com>
References: <20211116001545.2639333-1-eric.snowberg@oracle.com>
         <20211116001545.2639333-13-eric.snowberg@oracle.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-16.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: kCySSJ47vVqCCIFbpgP5mzT4BeSVnfXT
X-Proofpoint-ORIG-GUID: fhjBTn5cvmm0jQZCtKZqtwWcWDyUBcJZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-18_12,2021-11-17_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 lowpriorityscore=0 mlxlogscore=999 impostorscore=0 clxscore=1015
 spamscore=0 priorityscore=1501 suspectscore=0 adultscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111180122
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, 2021-11-15 at 19:15 -0500, Eric Snowberg wrote:
> With the introduction of the machine keyring, the end-user may choose to
> trust Machine Owner Keys (MOK) within the kernel. If they have chosen to
> trust them, the .machine keyring will contain these keys.  If not, the
> machine keyring will always be empty.  Update the restriction check to
> allow the secondary trusted keyring and ima keyring to also trust
> machine keys.
> 
> Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>

Reviewed-by:  Mimi Zohar <zohar@linux.ibm.com>

