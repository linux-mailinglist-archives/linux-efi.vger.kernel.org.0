Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E62AEDDBD3
	for <lists+linux-efi@lfdr.de>; Sun, 20 Oct 2019 03:22:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726246AbfJTBWA (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 19 Oct 2019 21:22:00 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:30112 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726036AbfJTBV7 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 19 Oct 2019 21:21:59 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x9K1Gvex099460
        for <linux-efi@vger.kernel.org>; Sat, 19 Oct 2019 21:21:58 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2vrceft2ej-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-efi@vger.kernel.org>; Sat, 19 Oct 2019 21:21:58 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-efi@vger.kernel.org> from <zohar@linux.ibm.com>;
        Sun, 20 Oct 2019 02:21:56 +0100
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sun, 20 Oct 2019 02:21:50 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x9K1LHP836897248
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 20 Oct 2019 01:21:17 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 198D711C04A;
        Sun, 20 Oct 2019 01:21:49 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D5AD811C050;
        Sun, 20 Oct 2019 01:21:46 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.181.232])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Sun, 20 Oct 2019 01:21:46 +0000 (GMT)
Subject: Re: [PATCH v8 5/8] ima: make process_buffer_measurement() generic
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Nayna Jain <nayna@linux.ibm.com>, linuxppc-dev@ozlabs.org,
        linux-efi@vger.kernel.org, linux-integrity@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Jeremy Kerr <jk@ozlabs.org>,
        Matthew Garret <matthew.garret@nebula.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Claudio Carvalho <cclaudio@linux.ibm.com>,
        George Wilson <gcwilson@linux.ibm.com>,
        Elaine Palmer <erpalmer@us.ibm.com>,
        Eric Ricther <erichte@linux.ibm.com>,
        "Oliver O'Halloran" <oohall@gmail.com>,
        Prakhar Srivastava <prsriva02@gmail.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Date:   Sat, 19 Oct 2019 21:21:46 -0400
In-Reply-To: <1571508377-23603-6-git-send-email-nayna@linux.ibm.com>
References: <1571508377-23603-1-git-send-email-nayna@linux.ibm.com>
         <1571508377-23603-6-git-send-email-nayna@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19102001-0012-0000-0000-0000035A2C42
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19102001-0013-0000-0000-000021955000
Message-Id: <1571534506.5250.339.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-10-19_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910200009
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sat, 2019-10-19 at 14:06 -0400, Nayna Jain wrote:
> process_buffer_measurement() is limited to measuring the kexec boot
> command line. This patch makes process_buffer_measurement() more
> generic, allowing it to measure other types of buffer data (e.g.
> blacklisted binary hashes or key hashes).

based on "func".
> 
> This patch modifies the function to conditionally retrieve the policy
> defined pcr and template based on the func.

This would be done in a subsequent patch, not here.

> @@ -642,19 +642,38 @@ static void process_buffer_measurement(const void *buf, int size,
>  					    .filename = eventname,
>  					    .buf = buf,
>  					    .buf_len = size};
> -	struct ima_template_desc *template_desc = NULL;
> +	struct ima_template_desc *template = NULL;
>  	struct {
>  		struct ima_digest_data hdr;
>  		char digest[IMA_MAX_DIGEST_SIZE];
>  	} hash = {};
>  	int violation = 0;
> -	int pcr = CONFIG_IMA_MEASURE_PCR_IDX;
>  	int action = 0;
> +	u32 secid;
>  
> -	action = ima_get_action(NULL, cred, secid, 0, KEXEC_CMDLINE, &pcr,
> -				&template_desc);
> -	if (!(action & IMA_MEASURE))
> -		return;
> +	if (func) {
> +		security_task_getsecid(current, &secid);
> +		action = ima_get_action(NULL, current_cred(), secid, 0, func,
> +					&pcr, &template);
> +		if (!(action & IMA_MEASURE))
> +			return;
> +	}
> +

Initially there is no need to test "func".  A specific "func" test
would be added as needed. 

Mimi

