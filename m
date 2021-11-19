Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F16C4566D8
	for <lists+linux-efi@lfdr.de>; Fri, 19 Nov 2021 01:06:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233495AbhKSAJ2 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 18 Nov 2021 19:09:28 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:37304 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S233355AbhKSAJ1 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 18 Nov 2021 19:09:27 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AINnN6V001208;
        Fri, 19 Nov 2021 00:06:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=kaVbZ9ugZUCZGNNCzGuJkXf8Htit8b2wgP9psUnZiUY=;
 b=YARFMxx3VA4MGemPk+k3q9D1zcCwA5s3OACam6qpLrDAP1HjPSxIeRW73oH0wwD/UhQ7
 uZzlhOBTXddBs+hiBh/Vr/YOhKvoTP9LcPhHTKgbKV6k1DGZV1cS0oqHoV0gU+/qHWbh
 07Bqjbbq7/rXAtTHDLABA9VpK56xbncodWLaixdO6YGM2jw+KrUh86frKinWWK5WvXK9
 xF3ynQ2Q5ROrzG10TU/Dcc9O09Ub6Jh0xB/jOQbs/QwBAdL4XvqRzvUHWiPg3N8Y3Dc2
 FhwJjyDCRcSjjknMgyTjM4EvuO0SZK8S71IdDpB9OxUNww+n05S1b/nOyHXGIubTddrl LA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3ce0u7g5un-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 Nov 2021 00:06:03 +0000
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1AJ062Os028069;
        Fri, 19 Nov 2021 00:06:02 GMT
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3ce0u7g5u0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 Nov 2021 00:06:02 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1AJ03otB011147;
        Fri, 19 Nov 2021 00:06:00 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma02fra.de.ibm.com with ESMTP id 3ca50ah49u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 19 Nov 2021 00:06:00 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1AJ05wIq13500718
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 19 Nov 2021 00:05:58 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6C7385204E;
        Fri, 19 Nov 2021 00:05:58 +0000 (GMT)
Received: from sig-9-65-86-194.ibm.com (unknown [9.65.86.194])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id B7C7152050;
        Fri, 19 Nov 2021 00:05:54 +0000 (GMT)
Message-ID: <cad01a17acc179cdd4ba2dabda68e7e0a49d9340.camel@linux.ibm.com>
Subject: Re: [PATCH v7 09/17] KEYS: Rename
 get_builtin_and_secondary_restriction
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
Date:   Thu, 18 Nov 2021 19:05:54 -0500
In-Reply-To: <20211116001545.2639333-10-eric.snowberg@oracle.com>
References: <20211116001545.2639333-1-eric.snowberg@oracle.com>
         <20211116001545.2639333-10-eric.snowberg@oracle.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-16.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: hxAXspTWE0T0Hctx6B_AQlS1c_eiGsfk
X-Proofpoint-ORIG-GUID: _ePAo9WAxzJ8OQP1n8ZruW4z0jJo6KZA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-18_12,2021-11-17_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 clxscore=1015 bulkscore=0 lowpriorityscore=0 adultscore=0
 spamscore=0 priorityscore=1501 mlxscore=0 malwarescore=0 mlxlogscore=999
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111180122
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi Eric,

On Mon, 2021-11-15 at 19:15 -0500, Eric Snowberg wrote:
> To improve clarity, rename get_builtin_and_secondary_restriction to
> get_secondary_restriction.

The existing name clarity is fine.  Perhaps instead prefix the above
sentence with "In preparation for returning either the existing
restrict_link_by_builtin_and_secondary_trusted or the new restriction
that includes the trusted builtin, secondary and machine keys, ..."
> 
> Suggested-by: Mimi Zohar <zohar@linux.ibm.com>
> Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>

Otherwise,
Reviewed-by:  Mimi Zohar <zohar@linux.ibm.com>

