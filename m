Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37C5762CEFF
	for <lists+linux-efi@lfdr.de>; Thu, 17 Nov 2022 00:44:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233056AbiKPXoo (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 16 Nov 2022 18:44:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232117AbiKPXol (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 16 Nov 2022 18:44:41 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C02162FB;
        Wed, 16 Nov 2022 15:44:40 -0800 (PST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AGNgMTD018883;
        Wed, 16 Nov 2022 23:44:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : reply-to : to : cc : date : in-reply-to : references : content-type
 : mime-version : content-transfer-encoding; s=pp1;
 bh=J1gnzsf/D1YTJY8T2+5NQLgeCtaYrxMGyExgYqnS8Wg=;
 b=C41DMRDD5aHvopRQA7Xc7BtxHDLvZO/6OXZMKnUQ5KQi1Bzz/OKsMo2qrglSffZOVCVr
 ZZgnR5EtEg8Q4yzOjiCcGH+iLlmRokr1+rs0HhRkgPQaimZaEsW2Uy9YAGb9KnmBnveh
 BPYtqLX1Hh2V/z4itIqhMME3k7H02jUyR5rmaSIz+djK6WB/zXsM3NLUDtNvkYgtOrsw
 3v3lxYlmZegfFX/39R+AVsGulYi0/VMSDQ1PF1/eJxzCenTEhKSoyHVf/pju6fdBJRkt
 rjPKTSHe90fhbVgNgV+qcpjCOvmEXVpFXHCZU+CGUKtMP+Pz7WfMZpU81xpPqhjOSTGe qg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3kw9s7010n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Nov 2022 23:44:23 +0000
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2AGNgWF8019113;
        Wed, 16 Nov 2022 23:44:22 GMT
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3kw9s7010g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Nov 2022 23:44:22 +0000
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2AGNZJHV020230;
        Wed, 16 Nov 2022 23:44:22 GMT
Received: from b03cxnp07027.gho.boulder.ibm.com (b03cxnp07027.gho.boulder.ibm.com [9.17.130.14])
        by ppma03dal.us.ibm.com with ESMTP id 3kt34a4ymw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Nov 2022 23:44:22 +0000
Received: from smtpav02.dal12v.mail.ibm.com ([9.208.128.128])
        by b03cxnp07027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2AGNiK7941681590
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Nov 2022 23:44:21 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A6EC95805A;
        Wed, 16 Nov 2022 23:44:20 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5577858051;
        Wed, 16 Nov 2022 23:44:19 +0000 (GMT)
Received: from sig-9-65-207-159.ibm.com (unknown [9.65.207.159])
        by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 16 Nov 2022 23:44:19 +0000 (GMT)
Message-ID: <c24c0f7c81ff24d791974ff7945e710b489b7e01.camel@linux.vnet.ibm.com>
Subject: Re: [PATCH v4 2/3] powerpc/pseries: PLPKS SED Opal keystore support
From:   Greg Joyce <gjoyce@linux.vnet.ibm.com>
Reply-To: gjoyce@linux.vnet.ibm.com
To:     "Elliott, Robert (Servers)" <elliott@hpe.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Cc:     "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "jonathan.derrick@linux.dev" <jonathan.derrick@linux.dev>,
        "brking@linux.vnet.ibm.com" <brking@linux.vnet.ibm.com>,
        "msuchanek@suse.de" <msuchanek@suse.de>,
        "mpe@ellerman.id.au" <mpe@ellerman.id.au>,
        "nayna@linux.ibm.com" <nayna@linux.ibm.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>,
        "dhowells@redhat.com" <dhowells@redhat.com>,
        "jarkko@kernel.org" <jarkko@kernel.org>
Date:   Wed, 16 Nov 2022 17:44:18 -0600
In-Reply-To: <MW5PR84MB1842689FD13382CAFCC260D8AB5F9@MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM>
References: <20220819223138.1457091-1-gjoyce@linux.vnet.ibm.com>
         <20220819223138.1457091-3-gjoyce@linux.vnet.ibm.com>
         <MW5PR84MB1842689FD13382CAFCC260D8AB5F9@MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: JgbknSy7aXhV73SxJYXrtnAvcD7UjiHr
X-Proofpoint-GUID: nGERouHv7XWg6rQBOqOkw7vipn-DPvyA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-16_03,2022-11-16_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 clxscore=1011
 mlxlogscore=999 spamscore=0 suspectscore=0 bulkscore=0 phishscore=0
 priorityscore=1501 impostorscore=0 adultscore=0 lowpriorityscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211160161
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, 2022-10-07 at 19:09 +0000, Elliott, Robert (Servers) wrote:
> > -----Original Message-----
> > From: gjoyce@linux.vnet.ibm.com <gjoyce@linux.vnet.ibm.com>
> > Sent: Friday, August 19, 2022 5:32 PM
> > To: linux-block@vger.kernel.org
> > Cc: linuxppc-dev@lists.ozlabs.org; jonathan.derrick@linux.dev;
> > brking@linux.vnet.ibm.com; msuchanek@suse.de; mpe@ellerman.id.au;
> > nayna@linux.ibm.com; axboe@kernel.dk; akpm@linux-foundation.org;
> > gjoyce@linux.vnet.ibm.com; linux-efi@vger.kernel.org;
> > keyrings@vger.kernel.org; dhowells@redhat.com; jarkko@kernel.org
> > Subject: [PATCH v4 2/3] powerpc/pseries: PLPKS SED Opal keystore
> > support
> > 
> > +++ b/arch/powerpc/platforms/pseries/plpks_sed_ops.c
> ...
> > +struct plpks_sed_object_data {
> > +	u_char version;
> > +	u_char pad1[7];
> > +	u_long authority;
> > +	u_long range;
> > +	u_int  key_len;
> > +	u_char key[32];
> > +};
> ...
> > +/*
> > + * Read the SED Opal key from PLPKS given the label
> > + */
> > +int sed_read_key(char *keyname, char *key, u_int *keylen)
> > +{
> ...
> > +	*keylen = be32_to_cpu(data->key_len);
> > +
> > +	if (var.data) {
> > +		memcpy(key, var.data + offset, var.datalen - offset);
> > +		key[*keylen] = '\0';
> 
> Is there a guarantee that key_len is always < sizeof key, or
> does that need to be checked in more places?

Changed keylen paramter to be the maximum size that it copied. This 
will help avoid buffer overwrite.


