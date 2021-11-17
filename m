Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D5C545470B
	for <lists+linux-efi@lfdr.de>; Wed, 17 Nov 2021 14:19:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237407AbhKQNVz (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 17 Nov 2021 08:21:55 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:37470 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231760AbhKQNVu (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 17 Nov 2021 08:21:50 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AHClXnl017359;
        Wed, 17 Nov 2021 13:18:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=kXeEaaSCbEFw0a9s/vACkhncL4RjstWCjc98cnX9yB8=;
 b=k+5NTJH2+VvxhE3nR6+9Bu2Cki2f2puvHVtLWq036qFeAN3ewurS5fXsMWGUQct37oBg
 JugBE3M0H+Vg7pbFRXyvGopzbmgj6RFf/kdc/lt2w2GgRQEog5KM/yloqXLwnSzKXk88
 CShjFplxPCiwDwGze1F16bDVYAt7QNju6S5HgLaMTJVL+/x1A3F+olFC/BzVJvHI7b1K
 uu6bCZiL6Xm7i0HG3Szv+Fc5tucXilqIFniu6Bjzvgp9VzpiKdVzSRr/7sYfMS9wo3BC
 r72UmDQOoFd+IoeWZr19ml9XWwmfXnqO+PndDcwrhS4n9oMvnrIAUi/qzz1xdUQf5Yjb 8w== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3cd2278kry-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 17 Nov 2021 13:18:34 +0000
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1AHCmsYf023587;
        Wed, 17 Nov 2021 13:18:34 GMT
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3cd2278kr9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 17 Nov 2021 13:18:34 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1AHD9ERU000321;
        Wed, 17 Nov 2021 13:18:32 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma02fra.de.ibm.com with ESMTP id 3ca50a0ryn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 17 Nov 2021 13:18:32 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1AHDBYIK49152306
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 Nov 2021 13:11:34 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 899F042041;
        Wed, 17 Nov 2021 13:18:29 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C748642042;
        Wed, 17 Nov 2021 13:18:26 +0000 (GMT)
Received: from sig-9-65-64-222.ibm.com (unknown [9.65.64.222])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 17 Nov 2021 13:18:26 +0000 (GMT)
Message-ID: <e35541f49db829a1ba25a2527adda6dbc7b7530a.camel@linux.ibm.com>
Subject: Re: [PATCH v7 02/17] integrity: Do not allow machine keyring
 updates following init
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
Date:   Wed, 17 Nov 2021 08:18:26 -0500
In-Reply-To: <20211116001545.2639333-3-eric.snowberg@oracle.com>
References: <20211116001545.2639333-1-eric.snowberg@oracle.com>
         <20211116001545.2639333-3-eric.snowberg@oracle.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-16.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: rSJD8sJq-VFxyT-rEPAZXrrhDpaA1cnB
X-Proofpoint-ORIG-GUID: TCmJMeuSYqfaXKaTlj1Xxq1PuE48hnJT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-17_04,2021-11-17_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 suspectscore=0
 impostorscore=0 adultscore=0 mlxlogscore=999 phishscore=0 clxscore=1015
 mlxscore=0 malwarescore=0 lowpriorityscore=0 priorityscore=1501
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111170067
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, 2021-11-15 at 19:15 -0500, Eric Snowberg wrote:
> The machine keyring is setup during init.  No additional keys should be
> allowed to be added afterwards.  Leave the permission as read only.
> 
> Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>

Reviewed-by:  Mimi Zohar <zohar@linux.ibm.com>

