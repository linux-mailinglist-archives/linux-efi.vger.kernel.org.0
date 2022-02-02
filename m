Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDB7D4A6F41
	for <lists+linux-efi@lfdr.de>; Wed,  2 Feb 2022 11:56:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231933AbiBBKze (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 2 Feb 2022 05:55:34 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:47266 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230095AbiBBKzd (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 2 Feb 2022 05:55:33 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2129a1RE002637;
        Wed, 2 Feb 2022 10:55:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=td31pKg7i3QQX7MS90cjPPRo4gypw4dOyz3DsANLTa4=;
 b=hSe2N0wR1Cy1aZQ3VGdbGo+tx/RW8Kmq5HUCHrvFDaFY2p9z8yBYFWcJEcVpIaDMtn7D
 4GRBwuqSqMhBDDs7dFTgTNukVX7trl4hXbkL5gFwe0oW6U4fwej1cZMuUQysjozBEq4z
 xxO4joUZkFHYcc2d8cOeKFLQPBG5P7sSAVukUEe3qrC4vrUTrnO3F6LzOPmSCTO3bVXc
 eCWzXuUljG10YKJGDOwBI8Hb2SnLeMY+JhHpvbpN/iXfEHeT1G+oRCqBlym4wGRAOHAr
 64OtMuiQTlGiQ6tRV2Ozg0YLFrtxnMnDM/BgNNk0X7kV4QNfVlr+K2SVG4sqXYhK9Xr7 bA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3dyfft8e5e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Feb 2022 10:55:18 +0000
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 212ARhJ3006010;
        Wed, 2 Feb 2022 10:55:18 GMT
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com [169.63.121.186])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3dyfft8e56-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Feb 2022 10:55:17 +0000
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
        by ppma03wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 212AtDit008509;
        Wed, 2 Feb 2022 10:55:17 GMT
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com [9.57.198.28])
        by ppma03wdc.us.ibm.com with ESMTP id 3dvw7b34e7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Feb 2022 10:55:17 +0000
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com [9.57.199.106])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 212AtGwi46399962
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 2 Feb 2022 10:55:16 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6A19E28068;
        Wed,  2 Feb 2022 10:55:16 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EDABB28060;
        Wed,  2 Feb 2022 10:55:11 +0000 (GMT)
Received: from [9.65.240.79] (unknown [9.65.240.79])
        by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed,  2 Feb 2022 10:55:11 +0000 (GMT)
Message-ID: <1035fbeb-3f03-e6e6-881d-fdf71eedd177@linux.ibm.com>
Date:   Wed, 2 Feb 2022 12:55:10 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v7 3/5] virt: Add efi_secret module to expose confidential
 computing secrets
Content-Language: en-US
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     linux-efi@vger.kernel.org, Borislav Petkov <bp@suse.de>,
        Ashish Kalra <ashish.kalra@amd.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Andi Kleen <ak@linux.intel.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Andrew Scull <ascull@google.com>,
        Dave Hansen <dave.hansen@intel.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        Lenny Szubowicz <lszubowi@redhat.com>,
        Peter Gonda <pgonda@google.com>,
        James Bottomley <jejb@linux.ibm.com>,
        Tobin Feldman-Fitzthum <tobin@linux.ibm.com>,
        Jim Cadden <jcadden@ibm.com>,
        Daniele Buono <dbuono@linux.vnet.ibm.com>,
        linux-coco@lists.linux.dev, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, Dov Murik <dovmurik@linux.ibm.com>
References: <20220201124413.1093099-1-dovmurik@linux.ibm.com>
 <20220201124413.1093099-4-dovmurik@linux.ibm.com>
 <20220202084512.2errjezf7ugrhntr@sirius.home.kraxel.org>
From:   Dov Murik <dovmurik@linux.ibm.com>
In-Reply-To: <20220202084512.2errjezf7ugrhntr@sirius.home.kraxel.org>
Content-Type: text/plain; charset=UTF-8
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: rko2_X9JcSm12lek0j2qvyBiQqK0xEts
X-Proofpoint-GUID: YbzNqheMUJavp9aSVWi4k0ZAv4YujC92
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-02_04,2022-02-01_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 priorityscore=1501 adultscore=0 phishscore=0 mlxlogscore=999
 malwarescore=0 suspectscore=0 impostorscore=0 clxscore=1015 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202020055
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org



On 02/02/2022 10:45, Gerd Hoffmann wrote:
>   Hi,
> 
>> +	s->coco_dir = NULL;
>> +	s->fs_dir = NULL;
>> +	memset(s->fs_files, 0, sizeof(s->fs_files));
>> +
>> +	dent = securityfs_create_dir("coco", NULL);
>> +	if (IS_ERR(dent)) {
>> +		pr_err("Error creating coco securityfs directory entry err=%ld\n", PTR_ERR(dent));
>> +		return PTR_ERR(dent);
>> +	}
>> +	s->coco_dir = dent;
>> +
>> +	dent = securityfs_create_dir("efi_secret", s->coco_dir);
>> +	if (IS_ERR(dent)) {
>> +		pr_err("Error creating efi_secret securityfs directory entry err=%ld\n",
>> +		       PTR_ERR(dent));
>> +		return PTR_ERR(dent);
>> +	}
>> +	d_inode(dent)->i_op = &efi_secret_dir_inode_operations;
>> +	s->fs_dir = dent;
> 
> Why have two levels of subdirectories here?  Do we expect more users for
> the coco/ directory?
> 

In the RFCv2 of this series Borislav Petkov suggested [1] adding a
"coco/" directory (originally it was "<securityfs>/sev_secret"); he
envisioned that other coco platforms (SNP, TDX) might want to expose
something to userspace via filesystem.

[1] https://lore.kernel.org/linux-coco/YNoiydeow+ftvfYX@zn.tnic/



> See also the naming discussion in the cover letter sub-thread.

Yep, following.



Thanks,
Dov
